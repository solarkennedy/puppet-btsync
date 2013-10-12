class btsync::config inherits btsync {

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
