<?php

// Generated by Haxe 3.3.0
class api_GameDataAPI {
	public function __construct() {}
	public function parseData() {
		$params = php_Web::getParams();
		$jsonStringData = $params->get("data");
		$jsonObj = haxe_Json::phpJsonDecode($jsonStringData);
		$gameData = new db_GameData();
		$gameData->username = $jsonObj->Username;
		$gameData->countryA2 = $jsonObj->Country;
		$gameData->scoreFor = $jsonObj->Scored;
		$gameData->scoreAgainst = $jsonObj->Conceded;
		$gameData->scoreDifference = $gameData->scoreFor - $gameData->scoreAgainst;
		$tmp = Date::now();
		$gameData->ts = api_GameDataAPI::convertToSQLDateTime($tmp);
		if($jsonObj->token === "lno\$E}uSN3i57V9") {
			db_Table::connect();
			$gameData->insert();
			db_Table::disconnect();
			php_Lib::hprint("<h2>Token valid<br>JSON parsed<br>Data added</h2>");
		} else {
			php_Lib::hprint("<h2>Token invalid</h2>");
		}
	}
	static function convertToSQLDateTime($h_date) {
		$t_date = null;
		$tmp = $h_date->getFullYear();
		$tmp1 = _hx_string_rec($tmp, "") . "-";
		$tmp2 = $h_date->getMonth();
		$tmp3 = _hx_string_or_null($tmp1) . _hx_string_rec(($tmp2 + 1), "") . "-";
		$tmp4 = $h_date->getDate();
		$t_date = _hx_string_or_null($tmp3) . _hx_string_rec($tmp4, "");
		return $t_date;
	}
	function __toString() { return 'api.GameDataAPI'; }
}
