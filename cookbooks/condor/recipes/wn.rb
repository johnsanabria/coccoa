execute "running install.bash" do
	user "root"
	cwd "/tmp/#{node[:condor][:compressedfilename]}"
	command "bash install.bash -t e -c #{node[:condor][:condormaster]} -p #{node[:condor][:installdir]} -u #{node[:condor][:condoruser]} -b -s"
	action :run
end
