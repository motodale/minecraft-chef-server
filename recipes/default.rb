include_recipe "java"

user "Steve" do
  home node[:minecraft][:dir]
end

remote_file "/server/minecraft/minecraft_server.#{node[:minecraft][:version]}.jar" do
  source "https://s3.amazonaws.com/Minecraft.Download/versions/#{[:minecraft][:version]}/minecraft_server.#{[:minecraft][:version]}.jar"
  owner "Steve"
  mode 0644
  action :create_if_missing
end

directory "#{node[:minecraft][:dir]}" do
  owner "Steve"
  action :create
end

service "minecraft" do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true, :reload => true
end

template "startup.conf" do
  path "/etc/init/startup.conf"
  source "startup.conf.erb"
  mode 0644
  notifies :restart, resources( :service => "minecraft")
end
