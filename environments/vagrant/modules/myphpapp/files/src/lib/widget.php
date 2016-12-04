<?php

class Widget {

  public function __construct( $app, $color ) {
    # always validate your inputs
    $this->app = $app;

    $this->validate_color($color);
    $this->color = $color;

    # TODO: INSERT IGNORE myphpapp (color) values(:color)
  }

  public function increment ( $count ) {
    # always validate your inputs
    $count = intval($count);
    $this->validate_count($count);

    # TODO: UPDATE myphpapp set count = count + :incr where color = :color
  }

  public static function all_by_key( $app ) {
    # TODO: select * from widgets
    return Array( "red" => array("color"=>"red","count"=>2), "green" => array("color"=>"green","count"=>1));
  }

  protected function validate_color($color) {
    if (!in_array($color, $this->app->config['colors'], true)) {
      throw new Exception('Invalid color: '. $color);
    }
  }

  protected function validate_count( $count ) {
    if ($count <= 0 || $count > 10) {
      throw new Exception('Invalid count: '.$count);
    }
  }
}
