class profile::base {
  user {'admin':
    ensure => present,
  }
  include profile::ssh_server
  
  # ensure that htop has been installed
  package {'htop':
    ensure => running,
  }
}
