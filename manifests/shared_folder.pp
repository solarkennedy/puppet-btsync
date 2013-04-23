define btsync::shared_folder(
  $secret,
  $use_relay_server = true,
  $use_tracker = true,
  $use_dht = true,
  $search_lan = true,
  $use_sync_trash = false,
  $known_hosts = [],
) {

  include btsync

  # Make sure the folder exists
  # You are welcome to define it elsewhere, but then it is your job
  # to make sure it has the correct permissions
  if ! defined(File[$name]){
    file { $name:
      ensure => directory,
      owner  => $btsync::user,
    }
  }

  concat::fragment { $name:
    order   => 15,
    content => template('btsync/shared_folder.erb'),
    target  => '/etc/btsync.conf',
  }

}
