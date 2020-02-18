<?php
/**
 * @package Example Plugin
 * @version 1.1.1
 */
/*
Plugin Name: Example Plugin
Plugin URI: http://wilbursoft.com
Description: This is not just a plugin.
Author: Guy Roberts
Version: 1.1.1
Author URI: http://wilbursoft.com
*/


// echos hello world.
function hello_world() {
	echo 'Hello world.';
}

// Register for the call back
add_action( 'admin_notices', 'hello_world' );



