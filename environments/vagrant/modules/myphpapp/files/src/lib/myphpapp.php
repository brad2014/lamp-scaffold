<?php

# if widget is a third party class, this might get loaded differently
require_once INSTALL_PATH .'/lib/widget.php';

class Myphpapp {
  protected $conn = null;
  public $config = null;

  public function __construct() {
    include MYPHPAPP_CONFIG_DIR . '/config.inc.php';
    include INSTALL_PATH . '/lib/default_config.php';

    $this->config = array_merge($default_config,$config);

    # connect to DB. Ref: https://secure.php.net/manual/en/book.pdo.php
    $dsn = sprintf('mysql:dbname=%s;host=%s;charset=UTF8', $this->config['db_name'], $this->config['db_host']);
    $this->conn = new PDO($dsn, $this->config['db_user'], $this->config['db_password']);  # TODO: exception handling
    $this->check_schema_version();
  }

  protected function check_schema_version() {
    # TODO: check the schema version against the software version, migrate the schema if they don't match.
  }

  public function do_function() {
    $body = '';
    if (array_key_exists('function', $_POST) && $_POST['function'] == 'increment') {
      $widget = new Widget($this, $_POST['color']);
      $widget->increment($_POST['increment']);
      $widget = null;
      $body .= '<div class="message"/>Widget count updated!</div>'."\n";
    }
    $all = Widget::all_by_key($this);
    ksort($all);
    $body .= '<table cellspacing="1" cellpadding="1" border="1" id="mpa_body">'."\n";
    # TODO: localize header strings
    $body .= sprintf("<thead><tr><th>%s</th><th>%s</th></tr></thead>\n<tbody>\n", "Color", "Count");
    foreach ( $all as $key => $val ) {
      $body .= sprintf( "<tr><td>%s</td><td>%s</td></tr>", $key, $val['count'] );
    }
    $body .= '</tbody></table>';
    return $body;
  }

  public function colname ( $name ) {
    return $this->config['db_column_prefix'] . $name;
  }

  public function tablename ( $name ) {
    return $this->config['db_table_prefix'] . $name;
  }
}
