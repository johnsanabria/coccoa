users Cookbook
==============
This cookbook creates a user.

Requirements
------------

Attributes
----------
#### users::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['users']['username']</tt></td>
    <td>String</td>
    <td>username of user. Password 'change me'</td>
    <td><tt>john</tt></td>
  </tr>
</table>

Usage
-----
#### users::default

```json
{
  "name":"my_node",
  "users": {
	"username": "juan"
  },
  "run_list": [
    "recipe[users]"
  ]
}
```

Contributing
------------

License and Authors
-------------------
Authors: John A Sanabria
