directory "/home/#{node[:users][:username]}/.ssh" do
        owner "cluster"
        group "admin"
        mode "0700"
        action :create
end
