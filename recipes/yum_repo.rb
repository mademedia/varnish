# Cookbook Name:: varnish
# Recipe:: yum_repo
# Author:: Jason Gaunt <jason.gaunt@mademedia.co.uk>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Small Ruby snippet to force yum to reload its cache when triggered
ruby_block "reload-internal-yum-cache" do
	block do
		Chef::Provider::Package::Yum::YumCache.instance.reload
	end
	action :nothing
end

# Pull in LWRPs from yum cookbook
include_recipe "yum"

# Build up yum config based on support RHEL versions
## By default it only enables the repo if node['varnish']['version'] matches the version number in the repo name
## This permits people to override this later with their own cookbooks
varnish_yum_platform_version = (node["varnish"]["yum_repo"]["override_platform_version"].nil? && node['platform_version'].to_i) || node["varnish"]["yum_repo"]["override_platform_version"]
varnish_yum_conf = ""

node["varnish"]["yum_repo"]["repositories"].each do |repo, platformversions|
	if platformversions.include? varnish_yum_platform_version.to_i
		if "varnish-" + node['varnish']['version'] == repo
			varnish_repo_enabled = 1
		else
			varnish_repo_enabled = 0
		end
		varnish_yum_conf += <<-END.gsub(/^[\t ]+/,'')
		[#{repo}]
		name=#{repo} for Enterprise Linux #{varnish_yum_platform_version.to_i} - $basearch
		baseurl=#{node["varnish"]["yum_repo"]["base_uri"]}/#{repo}/el#{varnish_yum_platform_version.to_i}/$basearch
		enabled=#{varnish_repo_enabled}
		gpgcheck=0
		
		END
	end
end

# Write yum conf
file node["varnish"]["yum_repo"]["conf_file"] do
	content varnish_yum_conf
	action :create
	notifies :create, "ruby_block[reload-internal-yum-cache]", :immediately
end
