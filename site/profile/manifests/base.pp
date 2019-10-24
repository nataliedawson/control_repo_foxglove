class profile::base {

  # use NTP module
  include ntp

  include profile::ssh_server
  
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
