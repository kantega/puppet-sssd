# Service mgmt for SSSD
class sssd::service inherits ::sssd::params {
  service { $::sssd::params::sssd_service_name:
    ensure => $::sssd::params::sssd_service_ensure,
    enable => $::sssd::params::sssd_service_enable,
  }
  exec { 'Restart SSSD service if backend is offline':
    command => '/bin/systemctl restart sssd',
    user => 'root',
    onlyif => '/bin/tail -n 1 /var/log/sssd/sssd_nss.log | /bin/grep "Error.DataProvider.Offline"',
  }
}
