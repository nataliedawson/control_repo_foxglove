class profile::base {
  user {'admin':
    ensure => present,
  }
  include profile::ssh_server
  
  # check for yum update
  class {'yum_cron':
    ensure        => 'present',
    apply_updates => true,    
  }
  
  # include epel-release repo to get access to htop package
  yumrepo {'epel-release':
    enabled  => 1,
    baseurl  => 'https://dl.fedoraproject.org/pub/epel/7/x86_64',
    descr    => 'Extra Packages for Enterprise Linux repository configuration',
    gpgcheck => 1,
    gpgkey   => 'https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7'
  }
  
  # install the htop package
  package {'htop':
    ensure   => 'installed',
    provider => 'yum',
  }
}
