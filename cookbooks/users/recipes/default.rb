user "#{node[:user][:username]}" do
        not_if "user id"
        comment "comment"
        home "/home/#{node[:users][:username]}"
        shell "/bin/bash"
        supports :manage_home => true
end

