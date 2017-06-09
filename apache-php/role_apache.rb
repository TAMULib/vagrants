name 'role_apache'
description 'Role for Vagrant Apache box using chef12. 
The omnibus_updater section is is required if using tl_base,
The tl_firewall section is required if using tl_base,
The rsyslog section server=true and server_ip setting is required for tl_base when used on Vagrant,
If you just an apache / php you only need the recipe[tl_app::apache] and recipe[tl_app::php],
I went ahead and included tl_base to get the generic stuff from systems and networking to ensure it all worked
'

run_list(
	"recipe[tl_app::apache]", 
	"recipe[tl_app::php]" 
)
default_attributes(
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