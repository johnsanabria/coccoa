#
# Cookbook Name:: packages
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
execute "update" do
        user "root"
        group "root"
        command "apt-get update"
        action :run
end
package "libmpich2-dev" do
        action :install
end
package "mpich2" do
        action :install
end
package "mpich2-doc" do
        action :install
end
package "openssh-server" do
        action :install
end
package "build-essential" do
        action :install
end
package "python-dev" do
	action :install
end
