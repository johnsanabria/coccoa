execute "update" do
        user "root"
        group "root"
        command "apt-get update"
        action :run
end
package "build-essential" do
        action :install
end
cookbook_file "/home/#{node[:users][:username]}/openmpi_demo.c" do
        source "openmpi_demo.c"
        mode "0644"
        owner "#{node[:users][:username]}"
end
template "/home/#{node[:users][:username]}/Makefile" do
        source "Makefile.erb"
        mode "0644"
        owner "#{node[:users][:username]}"
	variables(
		:shareddir => "#{node[:nfs][:shareddirectory]}"
	)
end
cookbook_file "/home/#{node[:users][:username]}/machinefile" do
        source "machinefile"
        mode "0644"
        owner "#{node[:users][:username]}"
end
