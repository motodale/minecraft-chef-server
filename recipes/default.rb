include_recipe "java"


remote_file "server/minecraft/minecraft_server.#{node['minecraft']['version']}.jar" do
  source "https://s3.amazonaws.com/Minecraft.Download/versions/#{['minecraft']['version']}/minecraft_server.#{['minecraft']['minecraft']}.jar"
end
