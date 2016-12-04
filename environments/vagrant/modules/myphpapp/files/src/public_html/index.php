<?php
  define('INSTALL_PATH', realpath(__DIR__ . '/..') . '/');
  require_once INSTALL_PATH . 'lib/init.php';
  try {
    $body = $app->do_function();
  } catch (Exception $e) {
    $body = 'Caught exception: ' . $e->getMessage() . "\n";
  }
?>
<html>
<head>
  <title>My PHP App</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      background: #dddddd;
      font-family: sans-serif;
    }
    #content {
      background: white;
      color: #331188;
      width: 500px;
      margin: 0 auto;
    }
    .message {
      margin: 2em;
      padding: 1em;
      background: #ffddaa;
      box-shadow: 3px 3px 3px #664422;
    }
    table {
      width: 3in;
    }
    .red {
      background: red;
      color: white;
    }
    .green {
      background: green;
      color: white;
    }
  </style>
</head>
<body>
  <div id="content">
    <img src="assets/bird_red.png" width="100" height="100"/>
    <h1>My PHP App</h1>
    <?php
    echo $body;
    ?>
    <hr/>
    <table><tr>
      <td>
        <form action="#" method="POST">
          <input type="hidden" name="color" value="red"/>
          <input type="hidden" name="increment" value="1"/>
          <input type="hidden" name="function" value="increment"/>
          <input type="submit" name="submit" value="More Red" class="red"/>
        </form>
      </td><td>
        <form action="#" method="POST">
          <input type="hidden" name="color" value="green"/>
          <input type="hidden" name="increment" value="1"/>
          <input type="hidden" name="function" value="increment"/>
          <input type="submit" name="submit" value="More Green" class="green"/>
        </form>
      </td>
    </tr></table>
  </div>
</body>
</html>
