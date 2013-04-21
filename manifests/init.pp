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

class btsync {
  include btsync::params
  include btsync::shared_folder

  service { 'btsync':
    ensure    => running,
    enable    => true,
    require   => File['/etc/init/btsync.conf'],
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

  # Make sure we have a user to run btsync with
  # Doesn't need anything special, just that it exists
  if ! defined(User["$btsync::params::user"]) {
    user { "$btsync::params::user": ensure => 'present', }
  }

  # Main btsync.conf file, contains all the shared folder stuff
  file { '/etc/btsync.conf':
    content => template('btsync/btsync.conf.erb'),
    owner   => root,
    group   => root,
    mode    => 444,
    notify  => Service['btsync'],
  }

}
