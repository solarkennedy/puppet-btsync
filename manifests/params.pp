class btsync::params {
  $user              = 'btsync'
  $device_name       = $::fqdn
  $listening_port    = 6881  # 0 - randomize port
  $check_for_updates = false
  $use_upnp          = true
  $download_limit    = '0' # in KB/s. 0 - unlimited
  $upload_limit      = '0'
}
