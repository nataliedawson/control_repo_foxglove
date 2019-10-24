node default {
 
  file {'/root/README':
    ensure  => file,
    content => 'This is a readme generated for a default node',
    owner   => 'root',
  }
}

node 'master.puppet.vm' {
  include role::master_server
  
  file {'/root/README':
    ensure => file,
    content => "Welcome to ${fqdn}\n",
  }
}

node /^web/ {
  include role::app_server
  
  file {'/root/README':
    ensure => file,
    content => "Welcome to ${fqdn}\n",
  }
}

node /^db/ {
  include role::db_server
}

node /^foxglove/ {
  include role::foxglove_server
}
