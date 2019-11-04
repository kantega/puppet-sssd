# Service mgmt for SSSD
class sssd::service inherits ::sssd::params {
  service { $::sssd::params::sssd_service_name:
    ensure => $::sssd::params::sssd_service_ensure,
    enable => $::sssd::params::sssd_service_enable,
  }
}
