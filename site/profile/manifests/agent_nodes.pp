class profile::agent_nodes {
  include dockeragent
  dockeragent::node {'web.puppet.vm':}
  dockeragent::node {'db.puppet.vm':}
  host {'web.puppet.vm':
    ensure => present,
    ip     => '172.18.0.3',
  }
  host {'db.puppet.vm':
    ensure => present,
    ip     => '172.18.0.2',
  }
  # add details for foxglove
  host {'foxglove.cs.ucl.ac.uk':
    ensure => present,
    ip     => '128.16.5.105',
  }
}
