if platform?("ubuntu") 
	execute "installing ganglia master" do
		user "root"
		command "export DEBIAN_FRONTEND=noninteractive; apt-get -y --force-yes install -qq ganglia-webfrontend ganglia-monitor rrdtool gmetad"
		action :run
	end
	execute "copy apache.conf to ganglia.conf " do
		user "root"
		command "cp /etc/ganglia-webfrontend/apache.conf /etc/apache2/sites-enabled/ganglia.conf"
		action :run
	end
	template "/etc/ganglia/gmetad.conf" do
		source "gmetad.conf.erb"
		mode 0644
		variables(
			:clustername => "#{node[:ganglia][:clustername]}",
			:polltime => "#{node[:ganglia][:polltime]}",
			:hostcollector => "#{node[:ganglia][:hostcollector]}",
			:portcollector => "#{node[:ganglia][:portcollector]}"
		)
	end
	template "/etc/ganglia/gmond.conf" do
		source "gmond.conf.erb"
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
	execute "starting gmetad" do
		command "/etc/init.d/gmetad restart"
		user "root"
	end
	execute "starting apache2" do
		command "/etc/init.d/apache2 restart"
		user "root"
	end
end
