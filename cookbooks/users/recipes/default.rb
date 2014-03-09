user "#{node[:users][:username]}" do
        comment "comment"
        home "/home/#{node[:users][:username]}"
        shell "/bin/bash"
        supports :manage_home => true
end

