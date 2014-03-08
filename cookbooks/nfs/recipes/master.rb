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
