#
# Cookbook Name:: condor
# Recipe:: default
#
# Copyright 2013, Universidad del Valle
#
# All rights reserved - Do Not Redistribute
#
user "#{node[:condor][:condoruser]}" do
        comment "comment"
        home "/home/#{node[:condor][:condoruser]}"
        shell "/bin/bash"
	password "$6$CBvuTlvb$UTYZMWBoFFxkOyu0HSGKQ/QtJd7Ta/OBvcZPuAMsiKehbGXCws9c2NuLPODElwx3YQDk0iu1U90uKlHIduwBu." # passwd: "change me"
        supports :manage_home => true
end
cookbook_file "/var/tmp/#{node[:condor][:compressedfilename]}.tar.gz" do
	source "#{node[:condor][:compressedfilename]}.tar.gz"
	mode 0664
	owner "#{node[:condor][:condoruser]}"
end

execute "tar" do
	user "#{node[:condor][:condoruser]}"
	cwd "/tmp"
	command "tar xfz /var/tmp/#{node[:condor][:compressedfilename]}.tar.gz"
	action :run
end

cookbook_file "/tmp/#{node[:condor][:compressedfilename]}/install.bash" do
	source "install.bash"
	mode 0755
	owner "#{node[:condor][:condoruser]}"
end
if platform?("ubuntu")
	execute "updating system" do
		user "root"
		command "apt-get update"
	end
else
	execute "updating system" do
		user "root"
		command "yum update -y"
	end
	execute "stopping the iptables service" do
		user "root"
		command "service iptables stop"
	end
	execute "disabling the iptables service" do
		user "root"
		command "chkconfig iptables off"
	end
end
