# Setup using Vagrant

First, fork and clone the repo. Then copy `Vagrantfile.example` and rename it to just `Vagrantfile`

```shell
$ cp Vagrantfile.example Vagrantfile
```

After installing [Vagrant](https://www.vagrantup.com/downloads.html) and [VirtualBox](https://www.virtualbox.org/wiki/Downloads) run command

```shell
$ vagrant up
```

to launch an Ubuntu 14.04 machine with all required dependencies installed.

This machine is provisioned using Ansible. The `playbook.yml` file defines the following roles (located in `roles/` folder):

- ubuntu_packages
- vagrant
- ruby: installs Ruby version 2.3.1
- nodejs
- postgres: installs PostgreSQL 9.5
- imagemagick

> You can learn more about Ansible on its [official documentation pages](http://docs.ansible.com/ansible/latest/index.html).

The first time the process might take a while. After it finishes provisioning you can login to the Vagrant machine issuing `vagrant ssh` command.

Don't forget to configure your local `database.yml` file. After that you'd only need to run:

1. `bundle install`
2. `rake db:schema:load`
3. and `rake db:seed`

to start using Ready Responder

## Starting rails server

When running rails server inside the vagrant machine (the guest) you'd need to `bind` the server IP to `0.0.0.0` otherwise it won't send any data to the host (your computer).

Launch the web server with command:

```shell
$ rails server -b 0.0.0.0
```

> You can read more on the reasoning of this [here](https://stackoverflow.com/a/27996166/1407371) and [here](http://edgeguides.rubyonrails.org/4_2_release_notes.html#default-host-for-rails-server)

## Ansible Roles

Ansible is a configuration management tool that can be used for many things including: configuration of systems, deploying software and orchestration.

One of the key features of Ansible is that it does not requires you to install agents on machines. It works by using OpenSSH.

### Roles

One of the ways of working Ansible is by using roles which are a way to reuse defined structures of tasks, variables and more.

You can see more in [Ansible roles documentation page](http://docs.ansible.com/ansible/latest/playbooks_reuse_roles.html).

This Vagrant + Ansible setup defines the following list of roles:

- `ubuntu_packages`: takes care of installing development dependencies (curl, git, build-essential, libs, and moar) and other software.
- `vagrant`: adds a line to machine `.profile` so that anytime you log in to the vagrant machine, you're automatically cd-ed to `/vagrant` folder
- `ruby`: install RVM, bundler and Ruby version 2.3.1
- `nodejs`: configures Nodesource nodejs repositories and installs latest NodeJS
- `postgres`: installs and configures PostgreSQL 9.5
- `imagemagick`: install Image Magick and its libraries