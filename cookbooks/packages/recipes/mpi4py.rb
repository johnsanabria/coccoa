#
# Installation details can be found at http://mpi4py.scipy.org/docs/usrman/install.html
#

cookbook_file "/tmp/mpi4py-1.3.1.tar.gz" do
	source "mpi4py-1.3.1.tar.gz"
	mode 0444
	owner "root"
	group "root"
end

execute "uncompress mpi4py" do
	user "#{node[:users][:username]}"
	group "#{node[:users][:username]}"
	cwd "/home/#{node[:users][:username]}"
	command "tar xfz /tmp/mpi4py-1.3.1.tar.gz"
	action :run
end

cookbook_file "/home/#{node[:users][:username]}/mpi4py-1.3.1/mpi.cfg" do
	source "mpi.cfg"
	user "#{node[:users][:username]}"
	group "#{node[:users][:username]}"
	mode 0644
end

execute "build mpi4py" do
	user "#{node[:users][:username]}"
	group "#{node[:users][:username]}"
	cwd "/home/#{node[:users][:username]}/mpi4py-1.3.1"
	command "python setup.py build"
	action :run
end

execute "install mpi4py" do
	user "root"
	group "root"
	cwd "/home/#{node[:users][:username]}/mpi4py-1.3.1"
	command "python setup.py install"
	action :run
end
