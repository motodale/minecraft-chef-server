include_recipe "apt"
include_recipe "java"

execute "apt-get update" do
    command "apt-get update"
    action :nothing
    not_if do ::File.exists?('/var/lib/apt/periodic/update-success-stamp') end
end.run_action(:run)

user "#{node['minecraft']['user']}" do
  home node['minecraft']['dir']
end

directory "#{node['minecraft']['dir']}" do
    owner "#{node['minecraft']['user']}"
    action :create
end

remote_file "/home/minecraft/minecraft.#{node['minecraft']['version']}.jar" do
  source "https://s3.amazonaws.com/Minecraft.Download/versions/#{node['minecraft']['version']}/minecraft_server.#{node['minecraft']['version']}.jar"
  owner "#{node['minecraft']['user']}"
  mode 0644
  action :create_if_missing
end

service "minecraft" do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true, :reload => true
end

template "minecraft.conf" do
  path "/etc/init/minecraft.conf"
  source "minecraft.conf.erb"
  mode 0644
  notifies :restart, resources( :service => "minecraft")
end
