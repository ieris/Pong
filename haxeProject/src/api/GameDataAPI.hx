package api;
import db.GameData;
import db.Table;
import haxe.Json;
import php.Lib;
import php.Web;
import sys.db.Types.SDateTime;
import sys.io.File;

/**
 * ...
 * @author Andrew Finlay
 */

class GameDataAPI 
{
	public function new() 
	{
		
	}
	
	public static function convertToSQLDateTime(h_date:Date):SDateTime 
	{
		var t_date:String;
		
		t_date = h_date.getFullYear() + "-" + (h_date.getMonth() + 1) + "-" + h_date.getDate() + " " + h_date.getHours() + ":" + h_date.getMinutes() + ":" + h_date.getSeconds();
 
		return cast(t_date, SDateTime);
	}
	
	public function addData() 
	{
		var filePath = "D:\\University\\301CR - Advanced Games Programming\\Assignment 2\\Leaderboard\\Leaderboard\\src\\gameData.json";
		var value = File.getContent(filePath);
		var json = Json.parse(value);
		
		
		var params = Web.getParams();
		
		var jsonStrData = params.get("data");
		
		var jsonObj = Json.parse(jsonStrData);
		
		var gameData = new GameData();
		
		gameData.username = json.Username;
		gameData.countryA2 = json.Country;
		gameData.scoreFor = json.Scored;
		gameData.scoreAgainst = json.Conceded;
		gameData.scoreDifference = gameData.scoreFor - gameData.scoreAgainst;
		gameData.ts = convertToSQLDateTime(Date.now());
		//gameData.ts = convertToSQLDateTime(new Date(2015, 7, 21, 13, 24, 1));
	
		Table.connect();
		gameData.insert();
		Table.disconnect();
		
		Lib.print("<h2>Added data</h2>");
	}
}