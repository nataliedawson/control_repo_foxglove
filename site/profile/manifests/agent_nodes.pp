class profile::agent_nodes {
  host {'foxglove.cs.ucl.ac.uk':
    ensure => present,
    ip     => '128.16.5.105',
  }
  
  # nr file names (more to rsync over)
  $nr_filenames = [
    'nr',
    'nr.00.phr',
    'nr.00.pin',
    'nr.00.psq',
    'nr.01.phr',
    'nr.01.pin',
    'nr.01.psq',
    'nr.02.phr',
    'nr.02.pin',
    'nr.02.psq',
    'nr.03.phr',
    'nr.03.pin',
    'nr.03.psq',
  ]
 
  # check that the expected directory structures are in place
  # for the webservices jobs (with same owner/group as phoenix)
  file {'/grid/gridstore2/cathgrid/nr':
    ensure => directory,
    #owner => 'cathgrid',
    #group => 'users',
  } ->  
  each($nr_filenames) |$nr_filename| {
    file { "/grid/gridstore2/cathgrid/nr/${nr_filename}":
      ensure => link,
      target => '/external/smb/vm/foxglove_data1/nr/${nr_filename}',
    }
  } 
  
  #->
  #file {'/grid/gridstore2/cathgrid/nr/nr':
  #  ensure => link,
  #  target => '/external/smb/vm/foxglove_data1/nr/nr',
  #}
  
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
