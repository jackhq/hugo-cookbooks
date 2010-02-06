# Zerigo DNS Cookbook

This cookbooks allows chef and chef-solo to set and configure
DNS Zones and Host via the Zerigo API

## Zerigo Attibutes

* version - specify version of zerigo_dns gem
* user - api user
* token - api token
* domain - domain for zone
* host - host for zone
* type - type of host ['A','CNAME', etc]
* ttl - Time Till Live
* data - data ['10.10.10.10','mydomain.com']

