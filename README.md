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
    
    ```
    # i.e.
    /export/software/perlbrew/perls/perl-5.12.5/bin/perl
    ```
    
    * Modify sge_conf settings in qconf so that min_uid, min_gid is 0, as on phoenix
    * Chown directories to apache:apache where needed (using puppet via github)
    * Change SELinux settings for directories so that apache user has permission to write to them
    * Point to correct qsub executable path: `/opt/gridengine/bin/lx-amd64/qsub`
    
    ```
    # this is what $PATH now looks like:
    [ucbtnld@foxglove ~]$ echo $PATH
    /opt/puppetlabs/puppet/bin:/home/ucbtnld/.local/bin:/home/ucbtnld/bin:/opt/gridengine/bin:/opt/gridengine/bin/lx-amd64:/usr/lib64/qt-3.3/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/opt/puppetlabs/bin
    ```
    
    * Ensure project name 'cath_update' exists
    
    ```
    # I've used the settings as on phoenix:
    [cathgrid@phoenix ~]$ qconf -sprj cath_update
    name cath_update
    oticket 0
    fshare 150
    acl NONE
    xacl NONE
    ```
    
    * Remove priority flag (-p) from qsub commands (currently automatically included, and apache user does not have authentication to permit postive increments of -p values, can only decrease priority).
    
        * For now have been submitting qsub commands manually and removed priority flag (-p) from qsub string.
        
        ```
        # apache@foxglove
        # run qsub without priority (-p) flag
        bash-4.2$ qsub -P cath_update -v PATH,PERL5LIB,CATHSCANCODE,CATH_VERSION -j y -o /grid/gridstore2/cathgrid/WebServicesTemp/8624/SID9594804131338624/SID9594804131338624.1.$JOB_ID -N SID9594804131338624 /grid/gridstore2/cathgrid/WebServicesTemp/8624/SID9594804131338624/SID9594804131338624.1.csh
        ```
        
     
    
    
