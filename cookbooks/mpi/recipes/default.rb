cookbook_file "/home/#{node[:users][:username]}/mpi_hello.c" do
        source "mpi_hello.c"
        mode "0644"
        owner "cluster"
end
cookbook_file "/home/#{node[:users][:username]}/Makefile" do
        source "Makefile"
        mode "0644"
        owner "cluster"
end
cookbook_file "/home/#{node[:users][:username]}/machinefile" do
        source "machinefile"
        mode "0644"
        owner "cluster"
end
#
# Instructions for mpi4py
#	
execute "copy helloworld.py" do
	user "vagrant"
	group "vagrant"
	cwd "/mirror"
	command "cp /home/vagrant/mpi4py-1.3.1/demo/helloworld.py ."
	action :run
end
