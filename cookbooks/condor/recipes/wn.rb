execute "running install.bash" do
	user "root"
	cwd "/tmp/#{node[:condor][:compressedfilename]}"
	command "bash install.bash -t e -c #{node[:condor][:condormaster]} -p #{node[:condor][:installdir]} -i #{node[:condor][:primaryip]} -u #{node[:condor][:condoruser]} -b -s"
	action :run
end
