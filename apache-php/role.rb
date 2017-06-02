name 'role'
description 'Role for Vagrant Apache box using chef12. 
The omnibus_updater section is is required if using tl_base,
The tl_firewall section is required if using tl_base,
The rsyslog section server=true and server_ip setting is required for tl_base when used on Vagrant,
For just an apache / php you only need the recipe[tl_app::apache] and recipe[tl_app::php]'

run_list(
	"recipe[tl_base]",
	"recipe[tl_app::apache]", 
	"recipe[tl_app::php]" 
)
override_attributes(
    'omnibus_updater': {
      'version': '12.15.19',
      'prevent_downgrade': 'true'
    },
  )
default_attributes(
    'tl_firewall': {
		'www': {
			'port': [80,443],
			'protocol': 'tcp'
		}
    },
   'rsyslog' => {
		'server' => 'true',
		'server_ip' => 'localhost'
    },	
	'tl_app' => {
		'apache' => {
			'vhost' => {
				'document_root' => '/data/www_root',
				'server_name' => 'localhost',
			},	
			'overrides' => {
				'EnableMMAP' => 'Off',
				'EnableSendfile' => 'Off',
			},				
		},
		'php' => {
			'packages' => ['ldap', 'mssql', 'mysqlnd']
		}
	},
)