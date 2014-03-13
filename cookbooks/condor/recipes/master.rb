execute "install" do
	user "root"
	cwd "/tmp/condor"
	command "bash install.bash -t ms -p #{node[:condor][:installdir]} -u #{node[:condor][:condoruser]} -d #{node[:condor][:condordomain]},#{node[:condor][:masterip]},10.0.2.15 -b -s"
	action :run
end
