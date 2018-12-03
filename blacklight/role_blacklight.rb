name 'role_apache'
description 'Role for Vagrant Apache box using chef12. 
If you just an apache / php you only need the recipe[tl_app::apache] and recipe[tl_app::php]
For Vagrant the document_root needs to match the syncDir : guest in the vagrant.yaml this allows for the sharing of directories
'
run_list(
	"recipe[tl_blacklight]"
)
default_attributes(
	'tl_blacklight' => {
		'deploy_branch' => 'tamu-blacklight',
		'solr_url': 'http://10.0.2.2:8983/solr/blacklight-core',
	},
	# 'tl_app' => {
	# 	'apache' => {
	# 		'vhost' => {
	# 			'document_root' => '/data/www_root',
	# 			'server_name' => 'localhost',
	# 		},	
	# 		'overrides' => {
	# 			'EnableMMAP' => 'Off',
	# 			'EnableSendfile' => 'Off',
	# 		},				
	# 	},
	# 	'php' => {
	# 		'packages' => ['ldap', 'mssql', 'mysqlnd'],
	# 		'mssql' => {
	# 			'mssql-prod1' => {
	# 			  'host' => 'mssql-prod1.library.tamu.edu',
	# 			  'instance' => 'mssqlprod1',
	# 			  'tds version' => '7.0',
	# 			},
	# 			'mssql-prod2' => {
	# 			  'host' => 'mssql-prod2.library.tamu.edu',
	# 			  'instance' => 'mssqlprod2',
	# 			  'tds version' => '7.0',
	# 			},  
	# 			'mssql-dev1' => {
	# 			  'host' => 'mssql-dev1.library.tamu.edu',
	# 			  'instance' => 'mssqldev1',
	# 			  'tds version' => '7.0',
	# 			},
	# 		},			
	# 	},
	# },
)