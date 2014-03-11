ssh Cookbook
============
This cookbook runs the proper commands to enable password-less ssh connection.
This recipe relies on value assigned to the default[:users][:username].

Requirements
------------

Attributes
----------

Usage
-----
Just include `ssh` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[ssh]"
  ]
}
```

Contributing
------------

License and Authors
-------------------
Authors: John A. Sanabria
