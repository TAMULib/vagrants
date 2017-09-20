name 'role_fedora'
description 'Role for Vagrant Fedora box using chef12.'

run_list(
	"recipe[tl_fedora::default]" 
)