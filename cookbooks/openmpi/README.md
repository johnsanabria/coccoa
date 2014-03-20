openmpi Cookbook
================
This cookbook helps to the installation of an openmpi cluster, I used this page as guide http://techtinkering.com/2009/12/02/setting-up-a-beowulf-cluster-using-open-mpi-on-linux/

Requirements
------------
This cookbook heavily relies on other recipes in this project such as
#### recipes
- `hostfiles` - this recipe creates a hosts file entry with info of all nodes deployed in the cluster
- `users` - creates a user for the cluster
- `openmpi` - installs all the packages required for an openmpi-based cluster
- `nfs` - sets up a shared file systems between master node and computational nodes of the cluster
- `ssh` - enables the password-less connection from master to any other node in the cluster



Attributes
----------
This recipe does not define its own attributes but heavily relies on attributes defined for hostsfile, nfs and users recipes.

Usage
-----
#### openmpi::default
Include `openmpi` and `openmpi::master` in your master's run list node and `openmpi` in your node's run list

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[openmpi]"
  ]
}
```

Contributing
------------

License and Authors
-------------------
Authors: John Alexander Sanabria
