execute "install" do
	user "root"
	cwd "/tmp/condor"
	command "bash install.bash -t e -c #{node[:condor][:condormaster]} -p #{node[:condor][:installdir]} -u #{node[:condor][:condoruser]} -b -s"
	action :run
end
