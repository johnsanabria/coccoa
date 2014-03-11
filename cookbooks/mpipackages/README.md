mpipackages Cookbook
==================
This cookbook installs all the packages required by a MPICH cluster.

Requirements
------------


Attributes
----------

Usage
-----
#### aptmirror::default
This is a regular definition of a role which would access your local mirror.


```json
{
  "name":"mpipackages",
  "chef_type":"role",
  "json_class":"Chef::Role",
  "run_list": [
    "recipe[mpipackages]"
  ]
}
```

Contributing
------------

License and Authors
-------------------
Authors: John Sanabria
