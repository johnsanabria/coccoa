cookbook_file "/home/#{node[:users][:username]}/.ssh/authorized_keys" do
        source "id_rsa.pub"
        mode 0644
        owner "#{node[:users][:username]}"
end
