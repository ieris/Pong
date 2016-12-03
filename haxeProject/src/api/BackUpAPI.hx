package api;
import db.GameData;
import db.Table;
import haxe.Json;
import php.Lib;
import php.Web;
import sys.db.Mysql;
import sys.db.Types;
import sys.io.File;

/**
 * ...
 * @author Andrew Finlay
 */

class BackUpAPI 
{
	public function new() 
	{
		
	}
	
	public static function convertToHaxeDateTime(s_date:SDate):Date 
	{
		var t_date:String;

		t_date = s_date.getFullYear() + "-" + (s_date.getMonth() + 1) + "-" + s_date.getDate();

		return Date.fromString(t_date);
	}
	
	public static function convertToSQLDateTime(h_date:Date):SDate 
	{
		var t_date:String;
		
		t_date = h_date.getFullYear() + "-" + (h_date.getMonth() + 1) + "-" + h_date.getDate();
 
		return cast(t_date, SDate);
	}
	
	public static function backupData()
	{
		var token = "B4{01PA5Nd";
		var params = Web.getParams();
		var str = params.get("token");

		var cnx = Mysql.connect
		({
			host : "localhost",
			port : 3306,
			user : "andrewco_admin",
			pass : "Ican£tthink",
			database : "andrewco_leaderboard",
			socket : null,
		});
		
		var JSON;
		var arrayOfRows = new Array();
		var data = {leaderboardData:arrayOfRows};
		
		if (str == token)
		{
			var req = cnx.request("SELECT * FROM GameData");
			
			for (row in req)
			{
				data.leaderboardData.push({ID: row.id, Username: row.username, Country: row.countryA2, Scored: row.scoreFor, Conceded: row.scoreAgainst, Score: row.scoreDifference, TS: convertToHaxeDateTime(row.ts)});
			}
			
			JSON = Json.stringify(data);
			
			Lib.print(JSON);
			
			var filePath = "backup.json";
			File.saveContent(filePath, JSON);
			
			Lib.print("<h2><br><br>SAVED TO FILE</h2>");
		}
		else
		{
			Lib.print("<h2>Token invalid</h2>");
		}
	}
	
	public static function restoreData()
	{
		var token = "UHT2QfT{653OV8";
		var params = Web.getParams();
		var str = params.get("token");
		
		var filePath = "backup.json";
		var value = File.getContent(filePath);
		var json = Json.parse(value);
		
		var gameData = new GameData();
		
		for (i in 0...50)
		{
			gameData.username = json[i].Username;
			gameData.countryA2 = json[i].Country;
			gameData.scoreFor = json[i].Scored;
			gameData.scoreAgainst = json[i].Conceded;
			gameData.scoreDifference = json[i].scoreFor - json[i].scoreAgainst;
			gameData.ts = json[i].ts;
		}
		
		if (str == token)
		{
			Table.connect();
			gameData.insert();
			Table.disconnect();
			
			Lib.print("<h2>Restored the backup data</h2>");
		}
		else
		{
			Lib.print("<h2>Token invalid</h2");
		}
	}
}