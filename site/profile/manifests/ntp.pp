class profile::ntp {
  class {'ntp':
    servers => ['master.puppet.vm', 'web.puppet.vm', 'db.puppet.vm', 'foxglove.cs.ucl.ac.uk'],
  }
}
