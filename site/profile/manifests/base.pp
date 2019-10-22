class profile::base {
  user {'admin':
    ensure => present,
  }
  include profile::ssh_server
  
  # include epel-release repo to get access to htop package
  yumrepo {'epel-release':
    enabled => 1,
    baseurl => 'https://dl.fedoraproject.org/pub/epel/7/x86_64',
    descr   => 'Extra Packages for Enterprise Linux repository configuration',
    gpgcheck => 1,
  }
  
  package {'htop':
    ensure   => 'installed',
    provider => 'yum',
  }
}
