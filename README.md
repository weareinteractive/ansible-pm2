# Ansible Pm2 Role

[![Build Status](https://travis-ci.org/weareinteractive/ansible-pm2.png?branch=master)](https://travis-ci.org/weareinteractive/ansible-pm2)
[![Stories in Ready](https://badge.waffle.io/weareinteractive/ansible-pm2.svg?label=ready&title=Ready)](http://waffle.io/weareinteractive/ansible-pm2)

> `pm2` is an [ansible](http://www.ansible.com) role which: 
> 
> * installs pm2
> * manages JSON apps
> * configures service

## Installation

Using `ansible-galaxy`:

```
$ ansible-galaxy install franklinkim.pm2
```

Using `arm` ([Ansible Role Manager](https://github.com/mirskytech/ansible-role-manager/)):

```
$ arm install franklinkim.pm2
```

Using `git`:

```
$ git clone https://github.com/weareinteractive/ansible-pm2.git
```

## Dependencies

* [franklinkim.nodejs](https://github.com/weareinteractive/ansible-nodejs)

## Variables

Here is a list of all the default variables for this role, which are also available in `defaults/main.yml`.

```
# pm2_apps:
#   - /var/www/myapp/pm2.json
#

# list of paths to JSON app declarations
pm2_apps: []
# startup system
pm2_startup: ubuntu
# start on boot
pm2_service_enabled: yes
# current state: started, stopped
pm2_service_state: started
```

## Handlers

* `restart pm2` 


## Example playbook

```
- host: all
  roles: 
    - franklinkim.pm2
  vars:
    pm2_startup: ubuntu
    pm2_apps:
      - /var/www/myapp/pm2.json
```

## Testing

```
$ git clone https://github.com/weareinteractive/ansible-pm2.git
$ cd ansible-pm2
$ vagrant up
```

## Contributing
In lieu of a formal styleguide, take care to maintain the existing coding style. Add unit tests and examples for any new or changed functionality.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License
Copyright (c) We Are Interactive under the MIT license.
