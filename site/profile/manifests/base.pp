class profile::base {
  user {'admin':
    ensure => present,
  }
  include profile::ssh_server
  
  # include epel-release repo to get access to htop package
  yumrepo {'epel-release':
    enabled => 1,
    descr   => 'Extra Packages for Enterprise Linux repository configuration'
    ensure  => present
  }
}
