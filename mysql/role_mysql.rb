name 'role_mysql'
description 'Role for Vagrant mySQL box using chef12.'

run_list(
	'recipe[tl_database::mysql-server]'
)
default_attributes(
	'mysql': {
		'version' => '5.7',
		'server' => {
			'data-dir': '/data/mysql',
			'initial-root-password': 'password'
		},
		'extra_settings' => {
			'sql_mode' => '""'
		},
	}
)