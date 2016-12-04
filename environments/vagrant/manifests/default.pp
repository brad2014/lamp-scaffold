Package {
  allow_virtual => false
}
File {
  owner => 'root',
  group => 'root'
}
Exec {
  path => '/usr/sbin:/sbin:/usr/bin:/bin',
}

include lamp_config
include myphpapp
