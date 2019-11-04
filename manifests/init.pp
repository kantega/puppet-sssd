# Init Class for sssd management module
class sssd {

  contain sssd::package
  contain sssd::config
  contain sssd::service
  contain sssd::params

  if $sssd::params::sssd_enable {
    Class['::sssd::package']
    -> Class['::sssd::config']
    -> Class['::sssd::service']
  }

}
