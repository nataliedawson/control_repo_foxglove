class profile::agent_nodes {
  host {'foxglove.cs.ucl.ac.uk':
    ensure => present,
    ip     => '128.16.5.105',
  }
  
  # check that the expected directory structures are in place
  # for the webservices jobs (with same owner/group as phoenix)
  file {'/grid/gridstore2/cathgrid/nr':
    ensure => directory,
    #owner => 'cathgrid',
    #group => 'users',
  }->
  file {'/grid/gridstore2/cathgrid/nr/nr':
    ensure => link,
    target => '/external/smb/vm/foxglove_data1/nr/nr',
  }
  
  file {'/grid/gridstore2/cathgrid/WebServices':
    ensure => directory,
    #owner => 'cathgrid',
    #group => 'users',
  }
  
  file {'/grid/gridstore2/cathgrid/WebServicesArchive':
    ensure => directory,
    owner => 'apache',
    group => 'apache',
  }
  
  file {'/grid/gridstore2/cathgrid/WebServicesTemp':
    ensure => directory,
    owner => 'apache',
    group => 'apache',
  }
  
  # ensure that there are symlinks in place for the nr files
  # https://puppet.com/docs/puppet/latest/types/file.html#file-attribute-source
  #file {'/grid/gridstore2/cathgrid/nr/':
  #  ensure => directory,
  #  target => '/external/smb/vm/foxglove_data1/nr/',
  #  links => manage,
  #}
    
  # check that the expected directory structure is in place
  # for hosting input data
  file {'/grid/gridstore2/cath/data/current':
    ensure => directory,
  }
}
