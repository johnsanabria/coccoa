mpi Cookbook
============
This cookbook installs all the MPICH packages required by a master and nodes computers.
Although this recipe does not define its own attributes, it needs two attributes from other two cookbooks users and nfs.

Requirements
------------
#### cookbooks
- `users` - A set of files for compiling and running a MPI program are allocated in a user's home directory. 
- `nfs` - MPICH shares files amongst processing nodes through a network file system.

Attributes
----------

Usage
-----
#### mpi::default

e.g.
Just include `mpi` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[mpi]"
  ]
}
```

Contributing
------------

License and Authors
-------------------
Authors: John A Sanabria
