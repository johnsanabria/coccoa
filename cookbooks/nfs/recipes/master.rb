if platform?("ubuntu")
	execute "update" do
		user "root"
		cwd "/tmp"
		command "apt-get update"
		action :run
	end
	package "nfs-kernel-server" do
		action :install
		options "--force-yes"
	end
	execute "exports" do
		user "root"
		command "echo \"#{node[:nfs][:shareddirectory]} *(rw,sync,no_root_squash,no_subtree_check)\" | sudo tee -a /etc/exports"
		action :run
	end
	# Service resource description -> http://docs.opscode.com/resource_service.html
	service "nfs-kernel-server" do
		supports :status => true, :restart => true, :reload => true
		action [ :enable, :restart ]
	end
else
	# include instructions for installing redhat based systems
	# check the execute resource ("exports") because it is possible
	# that is common to both systems
	package "nfs-utils" do
		action :install
		options "-y"
	end
	package "nfs-utils-lib" do
		action :install
		options "-y"
	end
	execute "exports" do
		user "root"
		command "echo \"#{node[:nfs][:shareddirectory]} *(rw,sync,no_root_squash,no_subtree_check)\" | sudo tee -a /etc/exports"
		action :run
	end
	service  "rpcbind" do
		supports :status => true, :restart => true, :reload => true
		action [ :enable, :restart ]
	end
	service  "nfs" do
		supports :status => true, :restart => true, :reload => true
		action [ :enable, :restart ]
	end
end
