# Ansible weareinteractive.pm2 role

[![Build Status](https://img.shields.io/travis/weareinteractive/ansible-pm2.svg)](https://travis-ci.org/weareinteractive/ansible-pm2)
[![Galaxy](http://img.shields.io/badge/galaxy-weareinteractive.pm2-blue.svg)](https://galaxy.ansible.com/weareinteractive/pm2)
[![GitHub Tags](https://img.shields.io/github/tag/weareinteractive/ansible-pm2.svg)](https://github.com/weareinteractive/ansible-pm2)
[![GitHub Stars](https://img.shields.io/github/stars/weareinteractive/ansible-pm2.svg)](https://github.com/weareinteractive/ansible-pm2)

> `weareinteractive.pm2` is an [Ansible](http://www.ansible.com) role which:
>
> * installs pm2
> * manages JSON apps
> * configures service

## Installation

Using `ansible-galaxy`:

```shell
$ ansible-galaxy install weareinteractive.pm2
```

Using `requirements.yml`:

```yaml
- src: weareinteractive.pm2
```

Using `git`:

```shell
$ git clone https://github.com/weareinteractive/ansible-pm2.git weareinteractive.pm2
```

## Dependencies

* Ansible >= 2.0
* installed nodejs i.e. with [weareinteractive.nodejs](https://github.com/weareinteractive/ansible-nodejs)

**Note:**

> Since Ansible Galaxy supports [organization](https://www.ansible.com/blog/ansible-galaxy-2-release) now, this role has moved from `franklinkim.pm2` to `weareinteractive.pm2`!

## Variables

Here is a list of all the default variables for this role, which are also available in `defaults/main.yml`.

```yaml
---
# pm2_apps:
#   - run: pm2.json               # you can also run a .js file like app.js
#     args: --name console_error  # optional arguements to pass i.e. to app.js
#     path: /var/www/myapp        # optional chdir path
#     env:                        # optional environment settings
#       NODE_ENV: production
#

# list of paths to JSON app declarations
pm2_apps: []
# startup system
pm2_startup: ubuntu
# service name for startup system
pm2_service_name: pm2-init.sh
# start on boot
pm2_service_enabled: yes
# current state: started, stopped
pm2_service_state: started
# version
pm2_version:

```

## Handlers

These are the handlers that are defined in `handlers/main.yml`.

```yaml
---

- name: restart pm2
  service:
    name: "{{ pm2_service_name }}"
    state: restarted
  when: pm2_service_state != 'stopped'

```


## Usage

This is an example playbook:

```yaml
---

- hosts: all
  # pre_tasks for installing dependencies for running the tests within docker
  pre_tasks:
    - name: Downloading install script
      get_url:
        url: https://deb.nodesource.com/setup_5.x
        dest: /tmp/setup_nodejs
        mode: "0777"
    - name: Installing sources
      command: /tmp/setup_nodejs
    - name: Installing packages
      action: "{{ ansible_pkg_mgr }} pkg=nodejs state=present"
  roles:
    - weareinteractive.pm2
  vars:
    pm2_apps:
      - run: apps.json
        path: "/etc/ansible/roles/weareinteractive.pm2/tests"
      - run: console_error.js
        args: --name console_error
        path: "/etc/ansible/roles/weareinteractive.pm2/tests/apps"
        env:
          NODE_ENV: dev
    pm2_startup: ubuntu

```


## Testing

```shell
$ git clone https://github.com/weareinteractive/ansible-pm2.git
$ cd ansible-pm2
$ make test
```

## Contributing
In lieu of a formal styleguide, take care to maintain the existing coding style. Add unit tests and examples for any new or changed functionality.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

*Note: To update the `README.md` file please install and run `ansible-role`:*

```shell
$ gem install ansible-role
$ ansible-role docgen
```

## License
Copyright (c) We Are Interactive under the MIT license.
