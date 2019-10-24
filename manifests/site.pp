node default {
  class {'ntp':
    servers => ['nist-time-server.eoni.com','nist1-lv.ustiming.org','ntp-nist.ldsbc.edu'],
  }
  
  file {'/root/README':
    ensure  => file,
    content => 'This is a readme',
    owner   => 'root',
  }
}

node 'master.puppet.vm' {
  class {'ntp':
    servers => ['nist-time-server.eoni.com','nist1-lv.ustiming.org','ntp-nist.ldsbc.edu'],
  }
  
  include role::master_server
  
  file {'/root/README':
    ensure => file,
    content => "Welcome to ${fqdn}\n",
  }
}

node /^web/ {
  class { 'ntp':
        servers => ['nist-time-server.eoni.com','nist1-lv.ustiming.org','ntp-nist.ldsbc.edu']
  }
  
  include role::app_server
}

node /^db/ {
  class { 'ntp':
        servers => ['nist-time-server.eoni.com','nist1-lv.ustiming.org','ntp-nist.ldsbc.edu']
  }
  
  include role::db_server
}

node /^foxglove/ {
  class { 'ntp':
        servers => ['nist-time-server.eoni.com','nist1-lv.ustiming.org','ntp-nist.ldsbc.edu']
  }
  
  include role::foxglove_server
}
