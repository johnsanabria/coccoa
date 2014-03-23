execute "running install.bash" do
	user "root"
	cwd "/tmp/#{node[:condor][:compressedfilename]}"
	command "bash install.bash -t ms -p #{node[:condor][:installdir]} -i #{node[:condor][:primaryip]} -u #{node[:condor][:condoruser]} -d #{node[:condor][:condordomain]},#{node[:condor][:masterip]},10.0.2.15 -b -s"
	action :run
end
