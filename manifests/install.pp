class btsync::install inherits btsync {

  # Directory to contain auxilary syncapp files
  file { '/var/btsync/':
    ensure => directory,
    owner  => $user,
    group  => 'root',
    mode   => '0700',
  }

  # Make sure we have a user to run btsync with
  # Doesn't need anything special, just that it exists
  if ! defined(User[$user]) {
    user { $user: ensure => 'present', }
  }

  # In the future there will probably be a better way to do this
  file { '/usr/bin/btsync':
    ensure => 'present',
    source => "puppet:///modules/btsync/btsync.${::architecture}",
    mode   => '0555',
  }

  # For convenience and lsb
  file { '/var/log/btsync.log':
    ensure => link,
    target => '/var/btsync/sync.log',
  }

}
