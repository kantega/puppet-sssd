# sssd

SSSD is a tool to integrate Linux hosts with a external user directory (AD/LDAP/etc)

## What does this module do

This module will in the following order:

* Install the necessary packages for sssd
* Roll out the `sssd.conf` (using lookup keys from Hiera)
* Update local auth services on the Linux host to use sssd
* Start/Restart the sssd service

## How can I use this module

Have a look in `templates/sssd.conf.erb` to see all the values that you will need to populate.
This variables point to `manifests/params.pp` which again have their own hiera-lookup keys, so the
"right" way to set the variables in this `.erb` file is through hiera

Note that the `ldap_default_authtok` expects the _obfuscated_ password string. You can generate this string with:

```
echo $your_password | sss_obfuscate -d $your_domain -s
```

This command will update `sssd.conf` and set the obfuscated password. This obfuscated string should be encrypted before being used in Hiera.

To have users log into the server with their ssh key, set which attribute in the user directory the ssh key resides (`ldap_user_ssh_public_key`), e.g. altSecurityIdentities
Also, if you're going to have users log in when their SSH keys, a couple of lines needs added in `/etc/ssh/sshd_config`:
```
AuthorizedKeysCommand /usr/bin/sss_ssh_authorizedkeys
AuthorizedKeysCommandUser nobody
```
The script `/usr/bin/sss_ssh_authorizedkeys` can be run interactivly to debug/test beforehand

If you need to add sudo rules that should apply to users/groups that reside in the external user directory, you can do something like this
```
cat /etc/sudoers.d/my_custom_sudo_rule
%linuxadmins@example.com ALL=(ALL) ALL
```
where `linuxadmins` is the group name and `example.com` is the domain (which you used in `sssd.conf`)




