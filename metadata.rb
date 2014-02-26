name             "minecraft-chef-server"
maintainer       "Dale Tibbetts"
maintainer_email "generaljeefus@gmail.com"
license          "All rights reserved"
description      "Installs/Configures a server"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version "0.0.2"

depends 'apt'
depends 'java'
depends 'minecraft-chef-server'
