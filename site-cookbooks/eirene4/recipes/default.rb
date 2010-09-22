include_recipe "packages"
include_recipe "gems"
include_recipe "github_keys"
include_recipe "hugo_deploy"
include_recipe "s3fs"
include_recipe 'memcached'


['database','s3','bucket','jasper'].each do |file|
  template "/home/ubuntu/apps/#{node[:hugo][:app][:name]}/shared/config/#{file}.yml" do
    owner "ubuntu"
    group "ubuntu"
    source "#{file}.erb"
  end

end

['s3','bucket','jasper'].each do |file|
  execute "ln" do
    command "ln -nsf /home/ubuntu/apps/#{node[:hugo][:app][:name]}/shared/config/#{file}.yml /home/ubuntu/apps/#{node[:hugo][:app][:name]}/current/config/#{file}.yml"
    action :run
  end
end

#include_recipe "delayed_job"

if node[:hugo][:app][:ssl]
  
  template "/home/ubuntu/apps/#{node[:hugo][:app][:name]}/current/public/.htaccess" do
    owner "ubuntu"
    group "ubuntu"
    source "htaccess.erb"
    mode 0644
  end
end

execute "ln" do
  command "ln -nsf /mnt/#{node[:s3][:bucket]} /home/ubuntu/apps/#{node[:hugo][:app][:name]}/current/public/docs"
  action :run
end
