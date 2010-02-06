bash "run bundle pack in app directory" do
  cwd File.join(node[:bundler][:apps_path], node[:bundler][:app], "current")
  code "bundle pack"
end
