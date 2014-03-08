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
                :hostname => "#{node[:hostconf][:hostname]}"
        )
end
# hosts file is created from a template file
cookbook_file "/tmp/hosts" do
        source "#{node[:hostconf][:hostsfile]}"
        mode 0644
        owner "root"
        group "root"
end
# append the new hosts to the existing hosts file
execute "cat #{node[:hostconf][:hostsfile]}" do
	user "root"
	command "cat /tmp/hosts >> /etc/hosts"
end
# the hostname service is restarted
execute "hostname" do
        user "root"
        group "root"
        command "/etc/init.d/hostname restart"
        action :run
end
