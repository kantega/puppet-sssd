# Configs for sssd
class sssd::config inherits sssd::params {

  file { 'SSSD config file':
    ensure  => file,
    path    => $sssd::params::sssd_config_file,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('sssd/sssd.conf.erb'),
  }
  ~>exec { 'Clean up SSSD cache':
    command     => 'rm -rf /var/lib/sss/db/*',
    user        => 'root',
    refreshonly => true,
    path        => ['/usr/bin','/usr/sbin'],
  }
  ~>exec { 'Update nsswitch to use sssd':
    command     => 'authconfig --enablesssd --update',
    user        => 'root',
    refreshonly => true,
    path        => ['/usr/bin','/usr/sbin'],
  }
  ~>exec { 'Update PAM to use sssd':
    command     => 'authconfig --enablesssdauth --update',
    user        => 'root',
    refreshonly => true,
    path        => ['/usr/bin','/usr/sbin'],
  }
  ~>exec { 'Update PAM to use oddjobb-mkhomedir':
    command     => 'authconfig --enablemkhomedir --update',
    user        => 'root',
    refreshonly => true,
    path        => ['/usr/bin','/usr/sbin'],
    notify  => Class[::sssd::service],
  }
  # For reference to why authconfig must be run see:
  # https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/system-level_authentication_guide/configuring_services
}
