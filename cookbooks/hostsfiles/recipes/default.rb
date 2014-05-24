# hosts file is created from a template file
cookbook_file "/tmp/hosts" do
        source "#{node[:hostsfiles][:hostsfile]}"
        mode 0644
        owner "root"
        group "root"
end
# hosts file is created from a template file
cookbook_file "/tmp/appendonlynew.py" do
        source "appendonlynew.py"
        mode 0755
        owner "root"
        group "root"
end
# append only new lines to the existing hosts file
execute "append new lines to hosts file" do
	user "root"
	cwd "/tmp"
	command "./appendonlynew.py /tmp/hosts /etc/hosts"
end
if platform?("ubuntu")
	include_recipe "hostsfiles::ubuntu"
else
	include_recipe "hostsfiles::centos"
end
