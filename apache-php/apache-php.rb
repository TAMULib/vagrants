name 'apache-php'

run_list(
	"recipe[tl_app::apache]", 
	"recipe[tl_app::php]" 
)

default_attributes(
	'tl_app' => {
		'apache' => {
			'vhost' => {
				'document_root' => '/data/html',
			},			
		},
		'php' => {
			'packages' => ['ldap', 'mssql', 'mysqlnd']
		}
	}
)