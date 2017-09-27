name 'role_srv-ftp'

run_list(
	"recipe[tl_publicftp]"	
)
override_attributes(
    
  )
default_attributes(
    'openssh' => {
      'server' => {
        'subsystem' => 'sftp        internal-sftp'
      }
    },
)