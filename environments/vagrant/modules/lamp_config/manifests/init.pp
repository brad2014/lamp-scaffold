class lamp_config (
  $root_mail
){
    include lamp_config::packages
    include lamp_config::apache
    include lamp_config::mysql

    mailalias {
      'root':
        recipient => $root_mail;
    } ~>
    exec {
      '/usr/sbin/postmap /etc/aliases':
        refreshonly => true;
    }
}
