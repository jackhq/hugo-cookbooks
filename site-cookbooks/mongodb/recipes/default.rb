

bash "install mongodb" do
  cwd "/tmp"
  code <<-EOH
  sudo mkdir -p /data/db
  curl -O http://hash.anthonyw.net/mongodb/mongodb_1.3.1_i386.deb
  sudo dpkg -i mongodb_1.3.1_i386.deb
  EOH
  
  not_if { File.exists?("/usr/bin/s3fs") }
end

if node[:mongodb][:system] == '32'
  # make default directory for data
  $ mkdir -p /data/db

  # using curl, get the pre-built distro
  $ curl -O http://downloads.mongodb.org/linux/mongodb-linux-i686-latest.tgz

  # unpack
  $ tar xzf mongodb-linux-i686-latest.tgz
end