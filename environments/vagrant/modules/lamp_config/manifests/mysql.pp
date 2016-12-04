class lamp_config::mysql (
  $root_password,
) {
  class {
    '::mysql::server':
      root_password => $root_password,
      remove_default_accounts => true;

    '::mysql::bindings':
      php_enable => true;
  }
}
