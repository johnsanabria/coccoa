nfs Cookbook
============
This cookbook installs the nfs service as much in a server as a client.

Requirements
------------

Attributes
----------

#### nfs::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['nfs']['shareddirectory']</tt></td>
    <td>String</td>
    <td>Directory which would be shared by master and nodes computers</td>
    <td><tt>/shared</tt></td>
  </tr>
</table>

Usage
-----
#### nfs::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `nfs` in your node's `run_list`:

```json
{
  "name":"my_node",
  "nfs": {
	"shareddirectory": "/cluster"
  },
  "run_list": [
    "recipe[nfs]"
  ]
}
```

Contributing
------------

License and Authors
-------------------
Authors: John A Sanabria
