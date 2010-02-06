bash "run bundle lock in app directory" do
  cwd File.join(node[:bundler][:apps_path], node[:bundler][:app], "current")
  code "bundle lock"
end
