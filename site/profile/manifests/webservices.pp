class profile::webservices {
  # install LDAP package is installed for apache
  package {'mod_ldap':
    ensure   => 'installed',
    provider => 'yum',
    require  => [Exec['exec-yum-clean']],
  }
}
