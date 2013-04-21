About
------
This is module makes it easy to manage shared folders using the BitTorrent
SyncApp (btsync). Think Dropbox with a bitorrent backend and no server. (and no storage
fees) Kinda like an eventually consistent filesystem. 

Installation
------------
    puppet module install KyleAnderson/btsync
Then put your btsync binary in the `btsync/files/` directory based on the arch:

    modules/btsync/files/btsync.x86_64
    modules/btsync/files/btsync.arm

Examples
-------
    btsync::shared_folder { '/media/sync': secret => 'HIKVMVKXNORH33X......' }

A more complicated example:
    btsync::shared_folder { '/media/sync': 
      secret           => 'HIKVMVKXNORH33X......' }
      use_relay_server => true,
      use_tracker      => false,
      use_dht          => true,
      search_lan       => true,
      use_sync_trash   => true,
      known_hosts      => [ "192.168.1.2:44444", "myhost.com:6881" ],
    }

License
-------
Apache License, Version 2.0

Contact
-------
Kyle Anderson <kyle@xkyle.com>

Support
-------

https://github.com/solarkennedy/puppet-btsync
