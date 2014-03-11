mpi4py Cookbook
==================
This cookbook compiles, configures and installs mpi4py

Requirements
------------
#### cookbooks
- `mpi`


Attributes
----------

Usage
-----
#### aptmirror::default


```json
{
  "name":"mpi4py",
  "chef_type":"role",
  "json_class":"Chef::Role",
  "run_list": [
    "recipe[mpi4py]"
  ]
}
```

Contributing
------------

License and Authors
-------------------
Authors: John Sanabria
