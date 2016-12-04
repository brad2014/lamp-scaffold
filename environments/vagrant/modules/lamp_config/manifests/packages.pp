#
# Simply load the packages listed in hiera
#

class lamp_config::packages (
  $add = []
) {
  package {
    $add:
      ensure => present;
  }

  exec {
    'tmp.mount':
      command => 'systemctl unmask tmp.mount; systemctl enable tmp.mount',
      unless => 'test `systemctl is-enabled tmp.mount` = enabled'
  }
}
