name 'role_tomcat'
description 'Role for Vagrant Apache box using chef12. 
If you just an apache / php you only need the recipe[tl_app::apache] and recipe[tl_app::php]
For Vagrant the document_root needs to match the syncDir : guest in the vagrant.yaml this allows for the sharing of directories
'

run_list(
	"recipe[tl_app::tomcat]" 
)
default_attributes(
	'tl_app' => {
		'tomcat' => {
			'home' => '/data/tomcat'
		},
	},
)