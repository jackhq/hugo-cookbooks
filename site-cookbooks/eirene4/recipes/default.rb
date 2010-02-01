appname = node[:application]

['database','s3','bucket','jasper'].each do |file|
  template "/home/ubuntu/apps/#{appname}/shared/config/#{file}.yml" do
    owner "ubuntu"
    group "ubuntu"
    source "#{file}.erb"
  end

end

['s3','bucket','jasper'].each do |file|
  execute "ln" do
    command "ln -nsf /home/ubuntu/apps/#{appname}/shared/config/#{file}.yml /home/ubuntu/apps/#{appname}/current/config/#{file}.yml"
    action :run
  end
end

#include_recipe "delayed_job"

if node[:app] and node[:app][:ssl]
  

  template "/home/ubuntu/apps/#{appname}/current/.htaccess" do
    owner "ubuntu"
    group "ubuntu"
    source "htaccess.erb"
    mode 0644
  end
end

if node[:s3] and node[:s3][:bucket]
  execute "ln" do
    command "ln -nsf /mnt/#{node[:s3][:bucket]} /home/ubuntu/apps/#{appname}/current/public/docs"
    action :run
  end
end
  