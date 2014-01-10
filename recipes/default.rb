include_recipe "java"
include_recipe "apt"

user "#{node['minecraft']['user']}" do
  home node['minecraft']['dir']
end

remote_file "/home/minecraft/minecraft.#{node['minecraft']['version']}.jar" do
  source "https://s3.amazonaws.com/Minecraft.Download/versions/#{node['minecraft']['version']}/minecraft_server.#{node['minecraft']['version']}.jar"
  owner "#{node['minecraft']['user']}"
  mode 0644
  action :create_if_missing
end

directory "#{node['minecraft']['dir']}" do
  owner "#{node['minecraft']['user']}"
  action :create
end

service "minecraft" do
  supports :status => true, :restart => true, :reload => true
end

template "startup.conf" do
  path "/etc/init/startup.conf"
  source "startup.conf.erb"
  mode 0644
  notifies :restart, resources( :service => "minecraft")
end
