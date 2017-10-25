# Ansible Roles

Ansible is a configuration management tool that can be used for many things including: configuration of systems, deploying software and orchestration.

One of the key features of Ansible is that it does not requires you to install agents on machines. It works by using OpenSSH.

## Roles

One of the ways of working Ansible is by using roles which are a way to reuse defined structures of tasks, variables and more.

You can see more in [Ansible roles documentation page](http://docs.ansible.com/ansible/latest/playbooks_reuse_roles.html).

This Vagrant + Ansible setup defines the following list of roles:

- `ubuntu_packages`: takes care of installing development dependencies (curl, git, build-essential, libs, and moar) and other software.
- `vagrant`: adds a line to machine `.profile` so that anytime you log in to the vagrant machine, you're automatically cd-ed to `/vagrant` folder
- `ruby`: install RVM, bundler and Ruby version 2.3.1
- `nodejs`: configures Nodesource nodejs repositories and installs latest NodeJS
- `postgres`: installs and configures PostgreSQL 9.5
- `imagemagick`: install Image Magick and its libraries