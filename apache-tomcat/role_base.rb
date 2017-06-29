name 'role_base'
description 'Role base for use with vagrant box running the tl_app cookbook / Apache box using chef12. 
The omnibus_updater version section is is required if using tl_base,
The tl_firewall section is used to ensure ports are open,
The rsyslog section server=true and server_ip setting is required for tl_base when used on Vagrant.  It basically says do not 
try and send logs we are just running it locally.
'

run_list(
	"recipe[tl_base]"
)
override_attributes(
    'omnibus_updater': {
      'version': '12.15.19',
      'prevent_downgrade': 'true'
    },
  )
default_attributes(
    'tl_firewall': {
		'tomcat': {
			'port': [9000],
			'protocol': 'tcp'
		}
    },
   'rsyslog' => {
		'server' => 'true',
		'server_ip' => 'localhost'
    },	
)