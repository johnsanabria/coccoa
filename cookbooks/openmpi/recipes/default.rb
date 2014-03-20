#
# Cookbook Name:: openmpi
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
execute "update" do
        user "root"
        group "root"
        command "apt-get update"
        action :run
end
package "openmpi-bin" do
        action :install
end
package "openmpi-common" do
        action :install
end
package "libopenmpi1.3" do
        action :install
end
package "libopenmpi-dev" do
        action :install
end
