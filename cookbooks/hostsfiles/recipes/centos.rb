ruby_block "change hostname" do
	block do
		rc = Chef::Util::FileEdit.new("/etc/sysconfig/network")
		rc.search_file_replace_line(/^HOSTNAME/,"HOSTNAME=#{node[:hostsfiles][:hostname]}")
		rc.write_file
	end
end
execute "hostname" do
        user "root"
        group "root"
        command "hostname #{node[:hostsfiles][:hostname]}"
        action :run
end
execute "network" do
        user "root"
        group "root"
        command "/etc/init.d/network restart"
        action :run
end
