appname = node[:hugo][:app][:name]
app_branch = node[:hugo][:app][:branch] if node[:hugo][:app][:branch]

directory "/home/ubuntu/apps/#{appname}" do
  owner "ubuntu"
  group "ubuntu"
  action :create
  recursive true
end

['config', 'log','pids'].each do |d|
  directory "/home/ubuntu/apps/#{appname}/shared/#{d}" do
    owner "ubuntu"
    group "ubuntu"
    action :create
    recursive true
  end
end


if node[:database] and node[:database][:name]
  ### Do Database config
  template "/home/ubuntu/apps/#{appname}/shared/config/database.yml" do
    owner "ubuntu"
    group "ubuntu"
    source "database.erb"
  end
  
  execute "ln" do
    command "ln -nsf /home/ubuntu/apps/#{appname}/shared/config/database.yml /home/ubuntu/apps/#{appname}/current/config/database.yml"
    action :run
  end
  
end

### Apache Config
template "/home/ubuntu/apps/#{appname}/shared/config/apache2.conf" do
  owner "ubuntu"
  group "ubuntu"  
  source "vhost.erb"
end


deploy "/home/ubuntu/apps/#{appname}" do
  if node[:github][:url]
    repo "#{node[:github][:url]}/#{appname}.git"
  end
  user node[:hugo][:app][:user] || "ubuntu"
  branch app_branch || "HEAD"
  environment node[:hugo][:app][:environment] || "production"
  if node[:hugo][:app][:restart_command]
    restart_command node[:hugo][:app][:restart_command]  
  else
    restart_command "touch tmp/restart.txt"
  end
  shallow_clone node[:hugo][:app][:shallow_clone] || true
  if node[:hugo][:app][:migrate]
    migrate node[:hugo][:app][:migrate]
  else
    migrate false
  end
  if node[:hugo][:app][:migration_command]
    migration_command node[:hugo][:app][:migration_command]
  else
    migration_command "rake db:migrate"
  end
  action node[:hugo][:app][:action] || :deploy
end



if node[:ssl]
  ### Apache SSL Public Key
  template "/etc/ssl/certs/#{appname}.crt" do
    owner "root"
    group "root"  
    source "publickey.erb"
  end

  ### Apache SSL Private Key
  template "/etc/ssl/certs/#{appname}.key" do
    owner "root"
    group "root"  
    source "privatekey.erb"
  end

  ### Apache GD Bundle
  template "/etc/ssl/certs/gd_bundle.crt" do
    owner "root"
    group "root"  
    source "gd_bundle.erb"
  end
end

file "/etc/apache2/sites-enabled/000-default" do
  action :delete
end

execute "ln" do
  command "sudo ln -nsf /home/ubuntu/apps/#{appname}/shared/config/apache2.conf /etc/apache2/sites-enabled/#{appname}"
  action :run
end



execute "ln" do
  command "ln -nsf /home/ubuntu/apps/#{appname}/shared/log /home/ubuntu/apps/#{appname}/current/log"
  action :run
end


#
# execute "/etc/init.d/apache2" do
#   command "/etc/init.d/apache2 restart"
#   action :run
# end
