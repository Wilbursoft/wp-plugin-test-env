<?php

/**
* Test example-plugin
*/
require_once "./example-plugin.php";

class ExamplePluginTest extends WP_UnitTestCase
{



    public function test_assert()
    {
        $this->assertTrue( true);
    }
    
    
    public function test_methods()
    {
        hello_world();
   		$this->assertTrue( false );
    }
    
    
}

