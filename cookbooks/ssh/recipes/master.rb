cookbook_file "/home/#{node[:users][:username]}/.ssh/id_rsa" do
        source "id_rsa"
        mode 0600
        owner "#{node[:users][:username]}"
end

cookbook_file "/home/#{node[:users][:username]}/.ssh/id_rsa.pub" do
        source "id_rsa.pub"
        mode 0644
        owner "#{node[:users][:username]}"
end
