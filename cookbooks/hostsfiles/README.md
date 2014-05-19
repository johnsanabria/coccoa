hostsfiles Cookbook
===================
This cookbook is used to deploy a hosts file in a machine and sets a hostname in the selected machine.  
This recipe uses two variables which are defined in the attributes/default.rb file.

default["hostsfiles"]["hostsfile"] = "hosts"
default["hostsfiles"]["hostname"] = "host"

The default["hostsfiles"]["hostsfile"] points to a hosts file which must exist in the files/default directory.  
On the other hand, default["hostsfiles"]["hostname"] has the name of the machine where this recipe is run.  

If any value is given 

Requirements
------------

Attributes
----------

e.g.
#### hostsfiles::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['hostsfiles']['hostname']</tt></td>
    <td>String</td>
    <td>Host name assigned to the machine</td>
    <td><tt>host</tt></td>
  </tr>
  <tr>
    <td><tt>['hostsfiles']['hostsfile']</tt></td>
    <td>String</td>
    <td>A typical hosts file. This file must exist in files/default directory</td>
    <td><tt>hosts</tt></td>
  </tr>
</table>

Usage
-----
#### hostsfiles::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `hostsfiles` in your node's `run_list`:

```json
{
  "name":"my_node",
  "hostsfiles": {
	"hostname": "master",
	"hostmaster": "master"
  },
  "run_list": [
    "recipe[hostsfiles]"
  ]
}
```

Contributing
------------

License and Authors
-------------------
Authors: John Sanabria
