user "#{node[:users][:username]}" do
        comment "comment"
        home "/home/#{node[:users][:username]}"
        shell "/bin/bash"
	password "$6$CBvuTlvb$UTYZMWBoFFxkOyu0HSGKQ/QtJd7Ta/OBvcZPuAMsiKehbGXCws9c2NuLPODElwx3YQDk0iu1U90uKlHIduwBu." # passwd: "change me"
        supports :manage_home => true
end

