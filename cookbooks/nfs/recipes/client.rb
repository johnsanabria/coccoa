if platform?("ubuntu")
	execute "update" do
		user "root"
		cwd "/tmp"
		command "apt-get update"
		action :run
	end
	package "nfs-common" do
		action :install
		options "--force-yes"
	end
else
	# modify considering characteristics of redhat based systems
	package "nfs-utils" do
		action :install
		options "-y"
	end
	package "nfs-utils-lib" do
		action :install
		options "-y"
	end
end

template "/tmp/fstab.tmp" do
        source "fstab.erb"
        mode 0666
        owner "root"
        variables(
                :headnode => "#{node[:hostsfiles][:hostmaster]}",
		:shareddir => "#{node[:nfs][:shareddirectory]}"
        )
end     
        
execute "modify fstab" do
        user "root"
        command "cat /tmp/fstab.tmp >> /etc/fstab"
        action :run
end

execute "mount" do
        user "root"
        command "mount -a"
        action :run
end
