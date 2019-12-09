# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include orengoapps::install
class orengoapps::install {

    # include cpan class
    # from puppet forge
    # to install perl modules
    #include '::cpan'

    # move to global config?

    $mafft_rpm_filename = 'mafft-7.427-gcc_fc6.x86_64.rpm'
    $ncbi_rpm_filename = 'ncbi-blast-2.9.0+-1.x86_64.rpm'
    $ccp4_rpm_filename = ''
    $hhsuite_dir = 'hhsuite-3.2.0-SSE2-Linux'
    $profit_filename = 'profit'
    $clustalw2_filename = 'clustalw2'
    $cath_tools_dirname = 'cath-tools-v0.16.2'
    $cath_tools_suffix = 'centos6'
    $cath_tools_filenames = [
        'cath-assign-domains',
        'cath-cluster',
        'cath-map-clusters',
        'cath-refine-align',
        'cath-resolve-hits',
        'cath-ssap',
        'cath-superpose',
    ]
    $sam_dir = 'sam'
    $prc_dir = 'prc'


    # clustalw2
    file { '/usr/bin/clustalw2':
        source => "puppet:///modules/orengoapps/${clustalw2_filename}",
        ensure => 'file',
        owner => 'root',
        group => 'root',
        mode => '0755',
    }
 
    # profit
    file { '/usr/bin/profit':
        source => "puppet:///modules/orengoapps/${profit_filename}",
        ensure => 'file',
        owner => 'root',
        group => 'root',
        mode => '0755',
    }

    # mafft
    file { "/tmp/${mafft_rpm_filename}":
        source => "puppet:///modules/orengoapps/${mafft_rpm_filename}",
        ensure => 'file',
    }
    ->
    exec { 'install-mafft':
        command => "rpm -Uvh /tmp/${mafft_rpm_filename}",
        path => '/bin:/usr/bin',
        creates => '/bin/mafft',
    }

    # blast
    package { 'perl-Archive-Tar':
        ensure => 'latest',
    }
    ->
    package { 'perl-List-MoreUtils':
        ensure => 'latest',
    }
    ->
    file { "/tmp/${ncbi_rpm_filename}":
        source => "puppet:///modules/orengoapps/${ncbi_rpm_filename}",
        ensure => 'file',
    }
    ->
    exec { 'install-ncbi':
        command => "rpm -Uvh /tmp/${ncbi_rpm_filename}",
        path => '/bin:/usr/bin',
        creates => '/bin/blastp',
    }

    
    # hhsuite
    file { "/usr/share/hhsuite":
        ensure => "directory",
        owner => "root",
    }->
    file { "/usr/share/hhsuite/data":
        ensure => "directory",
        source => "puppet:///modules/orengoapps/${hhsuite_dir}/data",
        recurse => true,
        owner => "root",
    }->
    file { "/usr/bin":
        source => "puppet:///modules/orengoapps/${hhsuite_dir}/bin",
        ensure => 'directory',
        recurse => true,
        owner => 'root',
        purge => false,
    }

    # cath-tools
    each($cath_tools_filenames) |$cath_tools_filename| {
        file { "/usr/bin/${cath_tools_filename}":
            ensure => "present",
            source => "puppet:///modules/orengoapps/${cath_tools_dirname}/${cath_tools_filename}.${cath_tools_suffix}",
            owner => 'root',
            group => 'root',
            mode => '0755',
        }
    }
    
    # sam
    file { "/usr/local/bin/${sam_dir}":
        source => "puppet:///modules/orengoapps/${sam_dir}",
        ensure => 'directory',
        recurse => true,
        owner => 'root',
        purge => true,
        mode => '0755',
    }
    
    # prc
    file { "/usr/local/bin/${prc_dir}":
        source => "puppet:///modules/orengoapps/${prc_dir}",
        ensure => 'directory',
        recurse => true,
        owner => 'root',
        purge => true,
        mode => '0755',
    }
}

