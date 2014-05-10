execute "apt-get update" do
	command "apt-get update"
	user "root"
	action :run
end
