class profile::base {
  
  # perform yum clean and update with cron
  cron {'yum-clean':
    command => '/bin/yum -y -q clean all',
    user    => 'root',
    hour    => 0,
    minute  => 0,
    weekday => 0,
  }
  
  cron {'yum-update':
    command => '/bin/yum -y -q update',
    user    => 'root',
    hour    => 1,
    minute  => 0,
    weekday => 1,
  }
  
  # command to perform yum clean
  exec {'exec-yum-clean':
    command => '/bin/yum -y -q clean all',
    user    => 'root',
  }
  
  # include epel-release repo to get access to htop package
  yumrepo {'epel-release':
    enabled  => 1,
    baseurl  => 'https://dl.fedoraproject.org/pub/epel/7/x86_64',
    descr    => 'Extra Packages for Enterprise Linux repository configuration',
    gpgcheck => 1,
    gpgkey   => 'https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7',
    require  => [Exec['exec-yum-clean']],
  }
  
  # install the htop package
  package {'htop':
    ensure   => 'installed',
    provider => 'yum',
    require  => [Exec['exec-yum-clean']],
  }
  
  # install lsof package to investigate ports
  package {'lsof':
    ensure   => 'installed',
    provider => 'yum',
    require  => [Exec['exec-yum-clean']],
  } 

}
