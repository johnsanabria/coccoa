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
if platform?("ubuntu")
	include_recipe "hostsfiles::ubuntu"
else
	include_recipe "hostsfiles::centos"
end
