# This is an example to configure a simple php/mysql app

class myphpapp (
  $db_password,
  $db_username = 'myphpapp',
  $db_name = 'myphpapp',
  $db_host = 'localhost',
  $owner = 'apache',
  $group = 'apache',
  $repo = 'https://www.github.com/brad2014/myphpapp.git',
  $branch = 'master',
  $installdir = '/usr/share/myphpapp',
){
  # install the files
  # typically:  source files in /usr/share/appname (readonly)
  # configuration files in /etc/appname (updated per installation)
  # run time files (uploads) in /var/lib/appname  (updated during use)
  # log files in /var/log/appname/ (needs to be managed by logrotate)

  # 1. the base install
  exec {
    "clone ${installdir}":
      require => Package['git'],
      command => "/usr/bin/git clone -b ${branch} ${repo} ${installdir}",
      creates => $installdir;

  } ->
  file {
    $installdir:
      owner => $owner,
      group => $group,
      recurse => true;
  } ->
  exec {
    "pull ${installdir}":
      command => 'cd ${installdir} && /usr/bin/git pull',
      unless => 'test "`/usr/bin/git status -z`" = ""';
  }

  # 2. configuration and runtime
  file {
    # configuration in /etc. CONTAINS SECRETS
    '/etc/myphpapp':
      ensure => directory,
      owner => $owner,
      group => $group,
      mode => '0770';
    '/etc/myphpapp/config.inc.php': # CONTAINS SECRETS
      content => template('myphpapp/config.inc.php');
    "${installdir}/config":  # note: autorequires /usr/share/myphpapp
      ensure => link,
      force => true,
      target => '../../../etc/myphpapp';

    # runtime temp files in /var/lib
    '/var/lib/myphpapp':
      ensure => directory,
      owner => $owner,
      group => $group,
      mode => '0770';
    "${installdir}/temp":
      ensure => link,
      force => true,
      target => '../../../var/lib/myphpapp';

    # log files in /var/log, rotated by logrotate.d
    '/var/log/myphpapp':
      ensure => directory,
      owner => $owner,
      group => $group,
      mode => '0770';
    "${installdir}/logs":
      ensure => link,
      force => true,
      target => '../../../var/log/myphpapp';

    '/etc/logrotate.d/myphpapp':
      content => template('myphpapp/logrotate.conf');
  }

  # point web server to our app  /myphpapp -> /usr/share/myphpapp/public_html/index.php
  ::apache::custom_config {
    'myphpapp':
      source => 'puppet:///modules/myphpapp/apache.conf';
  }

  # create the database
  ::mysql::db {
    $db_name:
      require => File[$installdir],
      user => $db_username,
      password => $db_password,
      sql => "${installdir}/SQL/schema.sql";
  }

  # other things you might have
  #  - daily maintainance scripts in /etc/cron.daily/... (e.g. /var/lib cleanup)
  #  - if the app is not carefully written, you may need to turn off SELinux

}
