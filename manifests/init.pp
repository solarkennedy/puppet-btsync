# == Class: btsync
#
# 
#
# === Parameters
#
# === Variables
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { btsync:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Kyle Anderson <kyle@xkyle.com>
#

class btsync(
  $user              = 'btsync',
  $device_name       = $::fqdn,
  $listening_port    = 6881,  # 0 - randomize port
  $check_for_updates = false,
  $use_upnp          = true,
  $download_limit    = '0', # in KB/s. 0 - unlimited
  $upload_limit      = '0',
  $known_hosts       = []
) {

  service { 'btsync':
    ensure    => running,
    enable    => true,
    require   => [ File['/etc/init/btsync.conf'],
                   File['/var/btsync'],
                   User["${btsync::user}"],
                ],
    subscribe => File['/etc/btsync.conf'],
  }

  # TODO: Add more disto support
  file { '/etc/init/btsync.conf':
    content => template('btsync/btsync.conf.init.erb'),
    owner   => root,
    group   => root,
    mode    => 444,
    notify  => Service['btsync'], # We might change the user in the template,
                                  # which should initiate a respawn of the service
  }

  # Directory to contain auxilary syncapp files
  file { '/var/btsync/':
    ensure => directory,
    owner  => $btsync::user,
    group  => 'root',
    mode   => 0700,
  }

  # Make sure we have a user to run btsync with
  # Doesn't need anything special, just that it exists
  if ! defined(User["$btsync::user"]) {
    user { "$btsync::user": ensure => 'present', }
  }

  # In the future there will probably be a better way to do this
  file { '/usr/bin/btsync':
    source => "puppet:///modules/btsync/btsync.${::architecture}",
    mode   => 0555,
    notify => Service['btsync'], # If this file changes for an update,
                                 # restart the service
  }
 
  # For convenience and lsb
  file { '/var/log/btsync.log':
    ensure => link,
    target => '/var/btsync/sync.log',
  }
  
  # Main btsync.conf file, contains all the shared folder stuff
  # it is a concatination of the main config, shared folders, then the footer
  concat { '/etc/btsync.conf':
    owner   => root,
    group   => root,
    mode    => 444,
    notify  => Service['btsync'],
  }
  
  # start of the json and main system config
  concat::fragment { 'btsync_header':
    content => template('btsync/btsync_header.conf.erb'),
    target  => '/etc/btsync.conf',
    order   => 01,
  }

  # the shared_folders have the middle pieces
 
  # The footer is at the end of the shared folders array json
  concat::fragment { 'btsync_footer':
    content => template('btsync/btsync_footer.conf.erb'),
    target  => '/etc/btsync.conf',
    order   => 99,
   } 

}
