name 'role_apache'
description 'Role for Vagrant Apache box using chef12. 
If you just an apache / php you only need the recipe[tl_app::apache] and recipe[tl_app::php]
For Vagrant the document_root needs to match the syncDir : guest in the vagrant.yaml this allows for the sharing of directories
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