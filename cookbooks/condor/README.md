condor Cookbook
===============
This cookbook installs a cluster condor.

Requirements
------------
This cookbook requires proper configuration of the hosts file (check `hostsfiles` recipe) and the creation of a user which will be in charge of manage the Condor deployment.

e.g.
#### packages
- `hostsfiles`
- `users`

Attributes
----------
#### condor::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['condor']['user']</tt></td>
    <td>String</td>
    <td>Name of the condor user</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['condor']['compressedfilename']</tt></td>
    <td>String</td>
    <td>Name of the file name (ignorde extension e.g. .tar.gz) where condor files are packaged. </td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['condor']['installdir']</tt></td>
    <td>String</td>
    <td>Name of the directory where condor will be installed.</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### condor::default
If you need to deploy a master you must include the following `run_listi`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[condor]",
    "recipe[condor:master]"
  ]
}
``

If you need to deploy a working node you must include the following `run_listi`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[condor]",
    "recipe[condor:wn]"
  ]
}
```

Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: TODO: List authors
