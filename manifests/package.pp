# Package definition for sssd module
class sssd::package inherits sssd::params {
  $sssd::params::packages.each | String $package | {
    if ! defined(Package[$package]) {
      package { "Installation of package ${package} in sssd module":
        ensure => installed,
        name   => $package,
      }
    }
  }
  if "${facts['os']['family']}${facts['os']['release']['major']}" == 'RedHat8' {
    package { 'Package for backwards compat authconfig':
      ensure => installed,
      name   => 'authselect-compat',
    }
  }
}
