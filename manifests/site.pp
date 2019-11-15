node default {
  class {'ntp':
    servers => ['nist-time-server.eoni.com','nist1-lv.ustiming.org','ntp-nist.ldsbc.edu'],
  }
 
  file {'/root/README':
    ensure  => file,
    content => 'This is a readme generated for a default node',
    owner   => 'root',
  }
}

node /^foxglove/ {
  include role::foxglove_server
}
