directory "/home/#{node[:users][:username]}/.ssh" do
        owner "#{node[:users][:username]}"
        mode "0700"
        action :create
end
