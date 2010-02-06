# Zerigo DNS Recipe Connects to Zerigo and create dns host
%w{ zerigo_dns }.each do |zerigo_dns_gem|
  gem_package zerigo_dns_gem do
    if node[:zerigo_dns][:version]
      version node[:zerigo_dns][:version]
      action :install
    else
      action :install
    end
  end
end

require 'zerigo_dns'

# Initialize Resouce
Zerigo::DNS::Base.user = node[:zerigo_dns][:user]
Zerigo::DNS::Base.password = node[:zerigo_dns][:token]

# find or create domain
zone = Zerigo::DNS::Base.find_or_create_zone(node[:zerigo_dns][:domain])

# find or create host
host = Zerigo::DNS::Host.update_or_create(
      :zone     => zone.id, 
      :host     => node[:zerigo_dns][:host], 
      :type     => node[:zerigo_dns][:type],
      :ttl      => node[:zerigo_dns][:ttl],
      :data     => node[:zerigo_dns][:data]  
  )
