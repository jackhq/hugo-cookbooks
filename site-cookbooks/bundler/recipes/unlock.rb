bash "run bundle unlock in app directory" do
  cwd File.join(node[:bundler][:apps_path], node[:bundler][:app], "current")
  code "bundle unlock"
end
