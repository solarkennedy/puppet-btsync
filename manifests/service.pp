class btsync::service inherits btsync {

  service { 'btsync':
    ensure    => $service_ensure,
    enable    => $service_enable,
    require   => File['/etc/init/btsync.conf'],
  }

  # TODO: Add more disto support
  file { '/etc/init/btsync.conf':
    content => template('btsync/btsync.conf.init.erb'),
    owner   => root,
    group   => root,
    mode    => '0444',
    notify  => Service['btsync'], # We might change the user in the template,
                                  # which should initiate a respawn of the service
  }

}
