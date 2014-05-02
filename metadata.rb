name              "varnish"
maintainer        "Opscode, Inc."
maintainer_email  "cookbooks@opscode.com"
license           "Apache 2.0"
description       "Installs and configures varnish"
version           "0.9.13"

depends "apt"
depends "yum"

recipe "varnish",      "Installs and configures varnish"
recipe "varnish::apt_repo", "Adds the official varnish project apt repository"
recipe "varnish::yum_repo", "Adds the official varnish project yum repository"

%w{ubuntu debian amazon redhat centos fedora}.each do |os|
  supports os
end
