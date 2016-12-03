package api;

import db.GameData;
import db.Table;
import haxe.Json;
import php.Lib;
import php.Web;
import sys.db.Types.SDate;
import sys.io.File;

/**
 * ...
 * @author Andrew Finlay
 */

class AddDataAPI 
{
	public function new() 
	{
		
	}
	
	public static function convertToSQLDateTime(h_date:Date):SDate 
	{
		var t_date:String;
		
		t_date = h_date.getFullYear() + "-" + (h_date.getMonth() + 1) + "-" + h_date.getDate();
 
		return cast(t_date, SDate);
	}
	
	public function parseData()
	{
		var token = "lno$E}uSN3i57V9";
		var params = Web.getParams();
		var jsonStringData = params.get("data");
		var jsonObj = Json.parse(jsonStringData);
		var gameData = new GameData();
		
		gameData.username = jsonObj.Username;
		gameData.countryA2 = jsonObj.Country;
		gameData.scoreFor = jsonObj.Scored;
		gameData.scoreAgainst = jsonObj.Conceded;
		gameData.scoreDifference = gameData.scoreFor - gameData.scoreAgainst;
		gameData.ts = convertToSQLDateTime(Date.now());
		
		if (jsonObj.token == token)
		{
			Table.connect();
			gameData.insert();
			Table.disconnect();
			
			Lib.print("<h2>Token valid<br>JSON parsed<br>Data added</h2>");
		}
		else
		{
			Lib.print("<h2>Token invalid</h2>");
		}
	}
}