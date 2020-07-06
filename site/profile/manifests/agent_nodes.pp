class profile::agent_nodes {
  host {'foxglove.cs.ucl.ac.uk':
    ensure => present,
    ip     => '128.16.5.105',
  }
  
  # nr file names
  # (for creating symlinks)
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
    'nr.04.phr',
    'nr.04.pin',
    'nr.04.psq',
    'nr.05.phr',
    'nr.05.pin',
    'nr.05.psq',
    'nr.06.phr',
    'nr.06.pin',
    'nr.06.psq',
    'nr.07.phr',
    'nr.07.pin',
    'nr.07.psq',
    'nr.08.phr',
    'nr.08.pin',
    'nr.08.psq',
    'nr.09.phr',
    'nr.09.pin',
    'nr.09.psq',
    'nr.10.phr',
    'nr.10.pin',
    'nr.10.psq',
    'nr.11.phr',
    'nr.11.pin',
    'nr.11.psq',
    'nr.12.phr',
    'nr.12.pin',
    'nr.12.psq',
    'nr.13.phr',
    'nr.13.pin',
    'nr.13.psq',
    'nr.14.phr',
    'nr.14.pin',
    'nr.14.psq',
    'nr.15.phr',
    'nr.15.pin',
    'nr.15.psq',
    'nr.16.phr',
    'nr.16.pin',
    'nr.16.psq',
    'nr.17.phr',
    'nr.17.pin',
    'nr.17.psq',
    'nr.18.phr',
    'nr.18.pin',
    'nr.18.psq',
    'nr.19.phr',
    'nr.19.pin',
    'nr.19.psq',
    'nr.20.phr',
    'nr.20.pin',
    'nr.20.psq',
    'nr.21.phr',
    'nr.21.pin',
    'nr.21.psq',
    'nr.22.phr',
    'nr.22.pin',
    'nr.22.psq',
    'nr.23.phr',
    'nr.23.pin',
    'nr.23.psq',
    'nr.24.phr',
    'nr.24.pin',
    'nr.24.psq',
    'nr.25.phr',
    'nr.25.pin',
    'nr.25.psq',
    'nr.26.phr',
    'nr.26.pin',
    'nr.26.psq',
    'nr.27.phr',
    'nr.27.pin',
    'nr.27.psq',
    'nr.28.phr',
    'nr.28.pin',
    'nr.28.psq',
    'nr.29.phr',
    'nr.29.pin',
    'nr.29.psq',
    'nr.30.phr',
    'nr.30.pin',
    'nr.30.psq',
    'nr.31.phr',
    'nr.31.pin',
    'nr.31.psq',
    'nr.32.phr',
    'nr.32.pin',
    'nr.32.psq',
    'nr.pal',
  ]
 
  # check that the expected directory structures are in place
  # for the webservices jobs (with same owner/group as phoenix)
  file {'/grid/gridstore2/cathgrid/nr':
    ensure => directory,
    #owner => 'cathgrid',
    #group => 'users',
  }
   
  file {'/grid/gridstore2/cathgrid/WebServices':
    ensure => directory,
    owner => 'apache',
    group => 'apache',
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
  each($nr_filenames) |$nr_filename| {
    file { "/grid/gridstore2/cathgrid/nr/${nr_filename}":
      ensure => link,
      target => "/external/smb/vm/foxglove_data1/nr/${nr_filename}",
    }
  } 
    
  # check that the expected directory structure is in place
  # for hosting input data
  file {'/grid/gridstore2/cath/data/current':
    ensure => directory,
  }
}
