<?php

// Generated by Haxe 3.3.0
class api_DisplayAPI {
	public function __construct() {}
	static function convertToHaxeDateTime($s_date) {
		$t_date = null;
		$tmp = $s_date->getFullYear();
		$tmp1 = _hx_string_rec($tmp, "") . "-";
		$tmp2 = $s_date->getMonth();
		$tmp3 = _hx_string_or_null($tmp1) . _hx_string_rec(($tmp2 + 1), "") . "-";
		$tmp4 = $s_date->getDate();
		$tmp5 = _hx_string_or_null($tmp3) . _hx_string_rec($tmp4, "") . " ";
		$tmp6 = $s_date->getHours();
		$tmp7 = _hx_string_or_null($tmp5) . _hx_string_rec($tmp6, "") . ":";
		$tmp8 = $s_date->getMinutes();
		$tmp9 = _hx_string_or_null($tmp7) . _hx_string_rec($tmp8, "") . ":";
		$tmp10 = $s_date->getSeconds();
		$t_date = _hx_string_or_null($tmp9) . _hx_string_rec($tmp10, "");
		return Date::fromString($t_date);
	}
	static function queryLeaderboard($query) {
		$cnx = sys_db_Mysql::connect(_hx_anonymous(array("host" => "localhost", "port" => 3306, "user" => "root", "pass" => "", "database" => "leaderboard", "socket" => null)));
		$req = $cnx->request($query);
		php_Lib::hprint("<body>" . "<table cellpadding=4; cellspacing=0>" . "<tr>" . "<th><font color=white><a href='/displayAll'>" . "All" . "</a></font></th>" . "<th><font color=white><a href='/displayTop10'>" . "Top 10" . "</a></font></th>" . "<th><font color=white><select onChange='window.location.href=this.value'>" . "<option value=''>Country</option>" . "<option value='/displayTop10'>ALL</option>" . "<option value='/displayCountry?country=GB'>GB</option>" . "<option value='displayCountry?country=IN'>IN</option>" . "<option value='displayCountry?country=IT'>IT</option>" . "<option value='displayCountry?country=LT'>LT</option>" . "</select></font></th>" . "<th><font color=white><a href='/displayYear'>" . "This Year" . "</a></font></th>" . "<th><font color=white><a href='/displayMonth'>" . "This Month" . "</a></font></th>" . "<th><font color=white><a href='/displayWeek'>" . "This Week" . "</a></font></th>" . "<th><font color=white><a href='/displayDay'>" . "Today" . "</a></font></th>" . "</tr></table>" . "<table border=1; cellpadding=4; cellspacing=0; style=border-collapse:collapse; bordercolor=f67ffff>" . "<tr>" . "<th style=background-color:#019e9e><font style=font-family:Verdana; color=white>RANK</font></th>" . "<th style=background-color:#019e9e><font style=font-family:Verdana; color=white>USERNAME</font></th>" . "<th style=background-color:#019e9e><font style=font-family:Verdana; color=white>COUNTRY</font></th>" . "<th style=background-color:#019e9e><font style=font-family:Verdana; color=white>SCORE</font></th>" . "<th style=background-color:#019e9e><font style=font-family:Verdana; color=white>TIMESTAMP</font></th>" . "<th style=background-color:#019e9e><font style=font-family:Verdana; color=white>ID</font></th>");
		$i = 1;
		while(true) {
			$tmp = !$req->hasNext();
			if($tmp) {
				break;
			}
			$row = $req->next();
			$tmp1 = "<tr>" . "<td style=background-color:#006666><font style=font-family:Verdana; color=white>" . _hx_string_rec($i, "") . "</font></td>" . "<td style=background-color:#006666><font style=font-family:Verdana; color=white>" . _hx_string_or_null($row->username) . "</font></td>" . "<td style=background-color:#006666><font style=font-family:Verdana; color=white>" . _hx_string_or_null($row->countryA2) . "</font></td>" . "<td style=background-color:#006666><font style=font-family:Verdana; color=white>" . _hx_string_or_null($row->scoreDifference) . "</font></td>" . "<td style=background-color:#006666><font style=font-family:Verdana; color=white>";
			$tmp2 = api_DisplayAPI::convertToHaxeDateTime($row->ts);
			$tmp3 = Std::string($tmp2);
			php_Lib::hprint(_hx_string_or_null($tmp1) . _hx_string_or_null($tmp3) . "</font></td>" . "<td style=background-color:#006666><font style=font-family:Verdana; color=white>" . _hx_string_or_null($row->id) . "</font></td>" . "</tr>");
			++$i;
			unset($tmp3,$tmp2,$tmp1,$tmp,$row);
		}
		php_Lib::hprint("</table></body>");
	}
	static function displayAll() {
		php_Lib::hprint("SELECT * FROM gamedata");
		api_DisplayAPI::queryLeaderboard("SELECT * FROM gamedata");
	}
	static function displayTop10() {
		php_Lib::hprint("SELECT * FROM gamedata ORDER by scoreDifference DESC LIMIT 10");
		api_DisplayAPI::queryLeaderboard("SELECT * FROM gamedata ORDER by scoreDifference DESC LIMIT 10");
	}
	static function displayCountry($country) {
		$query = "SELECT * FROM gamedata WHERE countryA2='" . _hx_string_or_null($country) . "' ORDER by scoreDifference DESC LIMIT 10";
		php_Lib::hprint($query);
		api_DisplayAPI::queryLeaderboard($query);
	}
	static function displayYear() {
		$tmp = Date::now()->getFullYear();
		$query = "SELECT * FROM gamedata WHERE ts LIKE '" . _hx_string_rec($tmp, "") . "-%' ORDER by scoreDifference DESC LIMIT 10";
		php_Lib::hprint($query);
		api_DisplayAPI::queryLeaderboard($query);
	}
	static function displayMonth() {
		$tmp = Date::now()->getFullYear();
		$tmp1 = "SELECT * FROM gamedata WHERE ts LIKE '" . _hx_string_rec($tmp, "") . "-";
		$tmp2 = Date::now()->getMonth();
		$query = _hx_string_or_null($tmp1) . _hx_string_rec(($tmp2 + 1), "") . "-%' ORDER by scoreDifference DESC LIMIT 10";
		php_Lib::hprint($query);
		api_DisplayAPI::queryLeaderboard($query);
	}
	static function displayWeek() {
		$tmp = Date::now()->getTime();
		$tmp1 = Date::fromTime($tmp - 604800000)->toString();
		$tmp2 = "SELECT * FROM gamedata WHERE ts BETWEEN '" . _hx_string_or_null($tmp1) . "' AND '";
		$tmp3 = Date::now()->toString();
		$query = _hx_string_or_null($tmp2) . _hx_string_or_null($tmp3) . "' ORDER by scoreDifference DESC LIMIT 10";
		php_Lib::hprint($query);
		api_DisplayAPI::queryLeaderboard($query);
	}
	static function displayDay() {
		$query = null;
		$tmp = Date::now()->getDate();
		if($tmp < 10) {
			$tmp1 = Date::now()->getDate();
			$query = "SELECT * FROM gamedata WHERE ts LIKE '%-0" . _hx_string_rec($tmp1, "") . "%' ORDER by scoreDifference DESC LIMIT 10";
		} else {
			$tmp2 = Date::now()->getDate();
			$query = "SELECT * FROM gamedata WHERE ts LIKE '%-" . _hx_string_rec($tmp2, "") . " %' ORDER by scoreDifference DESC LIMIT 10";
		}
		php_Lib::hprint($query);
		api_DisplayAPI::queryLeaderboard($query);
	}
	static function displayCustomDay($day) {
		$query = "SELECT * FROM gamedata WHERE ts LIKE '%-" . _hx_string_or_null($day) . "%' ORDER by scoreDifference DESC LIMIT 10";
		php_Lib::hprint($query);
		api_DisplayAPI::queryLeaderboard($query);
	}
	static function createJSON() {
		$cnx = sys_db_Mysql::connect(_hx_anonymous(array("host" => "localhost", "port" => 3306, "user" => "root", "pass" => "", "database" => "leaderboard", "socket" => null)));
		$req = $cnx->request("SELECT * FROM gamedata");
		$JSON = null;
		while(true) {
			$tmp = !$req->hasNext();
			if($tmp) {
				break;
			}
			$row = $req->next();
			$tmp1 = api_DisplayAPI::convertToHaxeDateTime($row->ts);
			$JSON = haxe_Json::phpJsonEncode(_hx_anonymous(array("Username" => $row->username, "Country" => $row->countryA2, "Score" => $row->scoreDifference, "TS" => $tmp1)), null, null);
			php_Lib::hprint(_hx_string_or_null($JSON) . "<br>");
			unset($tmp1,$tmp,$row);
		}
		sys_io_File::saveContent("C:\\University\\301CR - Advanced Games Programming\\Assignment 2\\Leaderboard\\Leaderboard\\src\\export.json", $JSON);
	}
	function __toString() { return 'api.DisplayAPI'; }
}
