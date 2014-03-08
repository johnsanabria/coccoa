execute "update" do
	user "root"
	cwd "/tmp"
	command "apt-get update"
	action :run
end
package "nfs-kernel-server" do
        action :install
end
