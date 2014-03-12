execute "install" do
	user "root"
	group "admin"
	cwd "/tmp/condor"
	command "bash install.bash -t e -c #{node[:condor][:domain]} -p #{node[:condor][:installdir]} -u #{node[:users][:username]} -b -s"
	action :run
end
