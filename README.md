# control_repo_foxglove
=======

This repo is used by puppet to configure the infrastructure on a given master node.

I have based this workflow on a puppet tutorial I followed on LinkedIn: `https://www.linkedin.com/learning/learning-puppet/`.

The following need installing on the master node:
* puppetserver
* vim
* git

```
# rpm -Uvh https://yum.puppet.com/puppet6-release-el-7.noarch.rpm
# yum install -y puppetserver vim git
```

* reduce memory requirements of puppetserver from 2Gb to 512Mb

```
# vim /etc/sysconfig/puppetserver
```

* start (and enable) server

```
systemctl start puppetserver
systemctl enable puppetserver
```

* add agent info to master puppet.conf

```
# vim /etc/puppetlabs/puppet/puppet.conf

# add:
[agent]
server = <name.of.master.node>
```

* edit bash profile to access install a ruby gem

```
# vim ~/.bash_profile
# add:
PATH=/opt/puppetlabs/puppet/bin:$PATH
# exec bash
# source ~/.bash_profile
```

* install ruby's r10k

```
# gem install r10k
```

* tell r10k where the control_repo is

```
# mkdir /etc/puppetlabs/r10k
# vim /etc/puppetlabs/r10k/r10k.yaml
# cat /etc/puppetlabs/r10k/r10k.yaml
---
# The location to use for storing cached Git repos
:cachedir: '/var/cache/r10k'

# A list of git repositories to create
:sources:
    # This will clone the git repository and instantiate an environment per
    # branch in /etc/puppetlabs/code/environments
    :my-org:
        remote: 'https://github.com/nataliedawson/control_repo.git'
        basedir: '/etc/puppetlabs/code/environments'
```

* updated site.pp to include foxglove node, which auto-updates `/etc/hosts` on master node
* updated `profile::agent_nodes.pp` to add foxglove host ip info
* added `role::foxglove_server.pp` to use base and webservices profiles


* deploy puppet

```
r10k deploy environment -p
puppet agent -t
```

* Have added in `orengoapps` module to install extra programs that will be needed

* Summary of other changes that have been made to get things working:
    * Get apache service (i.e. httpd) up and running
    * Ensure that foxglove has access to its own CGI scripts
    
    ```
    # as root@foxglove
    $ cd /var/www/cgi-bin
    $ ln -s /usr/local/svn/source/webservices/trunk/cgiscripts trunk

    # reload httpd
    $ systemctl reload httpd
    ```
    
    * Modify perl path in `/var/www/cgi-bin/trunk/CathScan.cgi` so that it uses the correct version of perl
    * Chown directories to apache:apache where needed
    * Change SELinux settings for directories so that apache user has permission to write to them
    * Point to correct qsub executable path: `/opt/gridengine/bin/lx-amd64/qsub`
    * Ensure project name 'cath_update' exists
    * Remove priority flag (-p) from qsub commands (currently automatically included, and apache user does not have authentication to permit postive increments of -p values, can only decrease priority).
    
    
