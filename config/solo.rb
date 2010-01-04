log_level          :info
log_location       STDOUT
file_cache_path File.join(File.dirname(__FILE__), '..')
cookbook_path [ File.join(File.dirname(__FILE__), '..', "site-cookbooks"), File.join(File.dirname(__FILE__), '..', "cookbooks") ]
role_path File.join(File.dirname(__FILE__), '..', "roles")
ssl_verify_mode    :verify_none
Chef::Log::Formatter.show_time = false
