if platform?("ubuntu")
	package "ganglia-monitor" do
		action :install
		options "-y --force-yes"
	end
	template "/etc/ganglia/gmond.conf" do
		source "gmond.conf.node.erb"
		mode 0644
		variables(
			:clustername => "#{node[:ganglia][:clustername]}",
			:hostcollector => "#{node[:ganglia][:hostcollector]}",
			:portcollector => "#{node[:ganglia][:portcollector]}"
		)
	end
	execute "starting ganglia-monitor" do
		command "/etc/init.d/ganglia-monitor restart"
		user "root"
	end
end
