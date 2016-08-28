<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

/**
 * Custom System library for CodeIgniter 3.x, which aims to make
 * easy some essential jobs for eclis
 *
 * @author		Agung Sukarno <agung_sukarno@ymail.com>
 *
 * @copyright 2014-2016 Agung Sukarno
 *
 * @version 1.0.0
 *
 * @license LGPL
 * @license http://opensource.org/licenses/LGPL-3.0 Lesser GNU Public License
 *
 */

class System {
	private $CI;
	private $data;

	function __construct() {

			$this->CI =& get_instance();
	 }

	 /**
		* Generate Side Menu
		* @param string $modul
		* @return string containing menu in HTML format
		*/
	 public function get_content($url){
    $ch = curl_init();

    curl_setopt ($ch, CURLOPT_URL, $url);
    curl_setopt ($ch, CURLOPT_HEADER, 0);

    ob_start();

    curl_exec ($ch);
    curl_close ($ch);
    $string = ob_get_contents();

    ob_end_clean();
    
    return $string;     
	}
}