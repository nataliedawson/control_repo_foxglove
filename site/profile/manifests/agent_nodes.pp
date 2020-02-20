class profile::agent_nodes {
  host {'foxglove.cs.ucl.ac.uk':
    ensure => present,
    ip     => '128.16.5.105',
  }
  
  # ensure that the expected directory structure is in place
  # for the webservices jobs
  file {'/grid/gridstore2/cathgrid/nr':
    ensure => directory,
  }
  
  
  # ensure that the expected directory structure is in place
  # for hosting input data
  file {'/grid/gridstore2/cath/data/current':
    ensure => directory,
  }
}
