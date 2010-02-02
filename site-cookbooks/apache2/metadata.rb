maintainer        "Jack Russell Software"
maintainer_email  "cookbooks@jackhq.com"
license           "Apache 2.0"
description       "Installs and configures all aspects of apache2 xsendfile using Debian style symlinks with helper definitions"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version           "0.10.0"
recipe            "apache2::mod_xsendfile", "Apache module 'alias' with config file"

%w{redhat centos debian ubuntu}.each do |os|
  supports os
end

