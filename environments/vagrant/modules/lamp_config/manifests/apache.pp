class lamp_config::apache {
  require ::apache
  require ::apache::mod::php

  ::apache::vhost {
    $fqdn:
      port => '80',
      docroot => '/var/www/html'
  }

  # punch a hole in the host's firewall to allow incoming connections to web server
  exec {
    'firewall-http':
      command => '/bin/firewall-cmd --add-service http --permanent && /bin/firewall-cmd --add-service http',
      unless => '/bin/firewall-cmd --query-service http';
  }
}
