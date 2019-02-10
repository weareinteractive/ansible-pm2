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

* Ansible >= 2.4
* installed nodejs i.e. with [weareinteractive.nodejs](https://github.com/weareinteractive/ansible-nodejs)

**Note:**

> Since Ansible Galaxy supports [organization](https://www.ansible.com/blog/ansible-galaxy-2-release) now, this role has moved from `franklinkim.pm2` to `weareinteractive.pm2`!

## Variables

Here is a list of all the default variables for this role, which are also available in `defaults/main.yml`.

```yaml
---
# pm2_cmds:
#   - run: sendSignal             # pm2 command name
#     args: SIGUSR2 my-app        # optional arguements to pass
#     path: /var/www/myapp        # optional chdir path
#     ignore_errors: yes          # optional don't fail on pm2 errors
#     env:                        # optional environment settings
#       NODE_ENV: production
# pm2_apps:
#   - run: pm2.json               # you can also run a .js file like app.js
#     cmd: start                  # optional command to run on the app
#     args: --name console_error  # optional arguements to pass i.e. to app.js
#     path: /var/www/myapp        # optional chdir path
#     env:                        # optional environment settings
#       NODE_ENV: production
# pm2_post_cmds:
#   - run: save                   # pm2 command name
#     args:                       # optional arguements to pass
#     path: /var/www/myapp        # optional chdir path
#     ignore_errors: yes          # optional don't fail on pm2 errors
#     env:                        # optional environment settings
#       NODE_ENV: production
#


# list of commands to run
# note: these will be executed before managing apps
pm2_cmds:
  # note: delete all apps initially on every run so only configured apps exist
  - run: delete all
# default env to run on cmds
pm2_cmds_default_env: {}
# list of post commands to run
# note: these will be executed after managing apps
pm2_post_cmds: []
# default env to run on post cmds
pm2_post_cmds_default_env: {}
# list of paths to JSON app declarations
pm2_apps: []
# default env to run on apps
pm2_apps_default_env: {}
# default command to run on apps
pm2_apps_default_cmd: start
# delete all initially on every run
pm2_apps_delete_all: yes
# install upstart
pm2_upstart: yes
# start on boot
pm2_service_enabled: yes
# service name for startup system
pm2_service_name: pm2-init.sh
# current state: started, stopped
pm2_service_state: started
# version
pm2_version:
# user to run pm2 commands
pm2_user: "{{ ansible_user_id }}"
# startup platform
pm2_platform:

```

## Handlers

These are the handlers that are defined in `handlers/main.yml`.

```yaml
---

- name: restart pm2
  service:
    name: "{{ pm2_service_name }}"
    state: restarted
  when: pm2_upstart and pm2_service_state != 'stopped'

- name: reload pm2
  service:
    name: "{{ pm2_service_name }}"
    state: reloaded
  when: pm2_upstart and pm2_service_state != 'stopped'

- name: update pm2
  shell: pm2 update
  when: pm2_upstart and pm2_service_state != 'stopped'

```


## Usage

This is an example playbook:

```yaml
---

- hosts: all
  become: yes
  roles:
    - weareinteractive.pm2
  vars:
    # For vagrant
    #pm2_upstart: yes
    #pm2_user: vagrant
    #pm2_service_name: pm2-vagrant
    # For docker
    pm2_user: root
    pm2_upstart: no # no service support within docker
    # Common
    pm2_cmds:
      - run: delete
        args: console_error
        ignore_errors: yes
    pm2_apps:
      - run: apps.json
        path: "/etc/ansible/roles/weareinteractive.pm2/tests"
        cmd: startOrGracefulReload
      - run: console_error.js
        args: --name console_error
        path: "/etc/ansible/roles/weareinteractive.pm2/tests/apps"
        cmd: start
        env:
          NODE_ENV: dev
    pm2_apps_default_env:
      NODE_ENV: production

```


## Testing

```shell
$ git clone https://github.com/weareinteractive/ansible-pm2.git
$ cd ansible-pm2
$ make test
```

## Contributing
In lieu of a formal style guide, take care to maintain the existing coding style. Add unit tests and examples for any new or changed functionality.

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
