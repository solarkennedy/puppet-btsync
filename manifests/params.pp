class btsync::params {
  $user              = 'btsync',
  $device_name       = $::fqdn,
  $listening_port    = 0,  # 0 - randomize port
  $storage_path      = "/home/$user/.sync",
  $pid_file          = "/var/run/btsync/btsync.pid",
  $check_for_updates = false,
  $use_upnp          = true,
  $download_limit    = '0',
  $upload_limit      = '0',
}
