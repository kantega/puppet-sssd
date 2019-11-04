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
}
