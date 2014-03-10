#
# Cookbook Name:: aptmirror
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
template "/etc/apt/sources.list" do
        source "sources.list.erb"
        mode 0644
        owner "root"
        group "root"
        variables(
                :hostname => "#{node[:aptmirror][:server]}"
        )
end

