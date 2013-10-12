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
#    servers => [ 'torrents1.local', 'torrents2.local' ]
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
  $known_hosts       = [],
  $service_enable    = true,
  $service_ensure    = 'running',
) {

  include '::btsync::install' 
  include '::btsync::service' 
  include '::btsync::config' 

  Class['::btsync::install'] -> Class['::btsync::config'] ~> Class['::btsync::service']

}
