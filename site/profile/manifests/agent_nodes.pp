class profile::agent_nodes {
  host {'foxglove.cs.ucl.ac.uk':
    ensure => present,
    ip     => '128.16.5.105',
  }
  
  # check that the expected directory structures are in place
  # for the webservices jobs
  file {'/grid/gridstore2/cathgrid/nr':
    ensure => directory,
  }
  
  file {'/grid/gridstore2/cathgrid/WebServices':
    ensure => directory,
  }
  
  file {'/grid/gridstore2/cathgrid/WebServicesArchive':
    ensure => directory,
  }
  
  file {'/grid/gridstore2/cathgrid/WebServicesTemp':
    ensure => directory,
    owner => 'apache',
    group => 'apache',
  }
  
  # check that the expected directory structure is in place
  # for hosting input data
  file {'/grid/gridstore2/cath/data/current':
    ensure => directory,
  }
}
