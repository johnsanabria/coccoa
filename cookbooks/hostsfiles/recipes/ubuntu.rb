#
# Cookbook Name:: hostsfiles
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# hostname file is created
template "/etc/hostname" do
        source "hostname.erb"
        mode 0644
        owner "root"
        group "root"
        variables(
                :hostname => "#{node[:hostsfiles][:hostname]}"
        )
end
# the hostname service is restarted
execute "hostname" do
        user "root"
        group "root"
        command "/etc/init.d/hostname restart"
        action :run
end
