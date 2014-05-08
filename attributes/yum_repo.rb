# Cookbook Name:: varnish
# Attributes:: yum_repo
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

default["varnish"]["yum_repo"]["conf_file"] = "/etc/yum.repos.d/varnish.repo"
default["varnish"]["yum_repo"]["base_uri"] = "http://repo.varnish-cache.org/redhat/"
default["varnish"]["yum_repo"]["override_platform_version"] = nil
default["varnish"]["yum_repo"]["priority"] = 20
default["varnish"]["yum_repo"]["repositories"] = {
	"varnish-2.1" => [5],
	"varnish-3.0" => [5, 6],
	"varnish-4.0" => [6]
}
