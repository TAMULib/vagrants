name 'apache-php'
description 'Role for Vagrant Apache box using chef12 omnibus_updater is required for tl_base'

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