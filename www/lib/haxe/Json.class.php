<?php

// Generated by Haxe 3.3.0
class haxe_Json {
	public function __construct(){}
	static function phpJsonDecode($json) {
		$val = json_decode($json);
		return haxe_Json::convertAfterDecode($val);
	}
	static function convertAfterDecode($val) {
		$arr = null;
		$tmp = is_object($val);
		if($tmp) {
			$arr1 = php_Lib::associativeArrayOfObject($val);
			$arr = array_map((isset(haxe_Json::$convertAfterDecode) ? haxe_Json::$convertAfterDecode: array("haxe_Json", "convertAfterDecode")), $arr1);
			return _hx_anonymous($arr);
		} else {
			$tmp1 = is_array($val);
			if($tmp1) {
				$arr = array_map((isset(haxe_Json::$convertAfterDecode) ? haxe_Json::$convertAfterDecode: array("haxe_Json", "convertAfterDecode")), $val);
				return new _hx_array($arr);
			} else {
				return $val;
			}
		}
	}
	function __toString() { return 'haxe.Json'; }
}
