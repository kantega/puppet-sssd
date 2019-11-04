# Parameteres used by the sssd module
class sssd::params {

  $packages = lookup(
    'sssd_package_name',
    Array,
    unique,
    ['sssd', 'sssd-tools', 'sssd-common', 'oddjob-mkhomedir']
  )
  $sssd_enable              = lookup('sssd_sssd_enable', Boolean, first, true)
  $sssd_service_name        = lookup('sssd_sssd_service_name', String, first, 'sssd')
  $sssd_service_ensure      = lookup('sssd_sssd_service_ensure', String, first, 'running')
  $sssd_service_enable      = lookup('sssd_sssd_service_enable', Boolean, first, true)
  $sssd_config_file         = lookup('sssd_sssd_config_file', String, first, '/etc/sssd/sssd.conf')
  $domain                   = lookup('sssd_domain', String, first, 'example.com')
  $domain_downcase          = downcase($domain)
  $domain_upcase            = upcase($domain)
  $ldap_uri                 = lookup('sssd_ldap_uri', String, first, 'ldaps://ldaps.example.com:3269')
  $ldap_search_base         = lookup('sssd_ldap_search_base', String, first, 'dc=example,dc=com')
  $ldap_default_bind_dn     = lookup('sssd_ldap_default_bind_dn', String, first, 'binduser')
  $ldap_default_authtok     = lookup('sssd_ldap_default_authtok', String, first, 'insert_obfuscated_password')
  $ldap_user_ssh_public_key = lookup('sssd_ldap_user_ssh_public_key', String, first, 'altSecurityIdentities')
  $ldap_tls_reqcert         = lookup('sssd_ldap_tls_reqcert', String, first, 'demand')
  $simple_allow_groups      = lookup('sssd_simple_allow_groups', Array, unique, ['DUMMY_GROUP_TO_AVOID_PERMITTING_ACCESS_TO_ALL'])

}
