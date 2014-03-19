#
# Cookbook Name:: nfs
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
directory "#{node[:nfs][:shareddirectory]}" do
        owner "root"
        group "root"
        mode 0777
        action :create
end
execute "change permissions to #{node[:nfs][:shareddirectory]}" do
        user "root"
        command "chmod 1777 #{node[:nfs][:shareddirectory]}"
        action :run
end

