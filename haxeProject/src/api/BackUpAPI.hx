package api;
import db.GameData;
import db.Table;
import haxe.Json;
import php.Lib;
import php.Web;
import sys.FileSystem;
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
	
	public static function convertToHaxeDateTime(s_date:SDateTime):Date 
	{
		var t_date:String;

		t_date = s_date.getFullYear() + "-" + (s_date.getMonth() + 1) + "-" + s_date.getDate() + " " + s_date.getHours() + ":" + s_date.getMinutes() + ":" + s_date.getSeconds();

		return Date.fromString(t_date);
	}
	
	public static function convertToSQLDateTime(h_date:Date):SDateTime
	{
		var t_date:String;
		
		t_date = h_date.getFullYear() + "-" + (h_date.getMonth() + 1) + "-" + h_date.getDate() + " " + h_date.getHours() + ":" + h_date.getMinutes() + ":" + h_date.getSeconds();
 
		return cast(t_date, SDateTime);
	}
	
	public static function backupData()
	{
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
		
		var req = cnx.request("SELECT * FROM GameData");
		
		for (row in req)
		{
			data.leaderboardData.push({ID: row.id, Username: row.username, Country: row.countryA2, Scored: row.scoreFor, Conceded: row.scoreAgainst, Score: row.scoreDifference, TS: row.ts});
		}
		
		JSON = Json.stringify(data);
		
		Lib.print(JSON);
		
		var filePath = "backup.json";
		File.saveContent(filePath, JSON);
		
		Lib.print("<h2><br>Backup file has been created</h2>");

	}
	
	public static function restoreData()
	{
		var filePath = "backup.json";
		var json:Dynamic;
		
		var acptToken = "^2J{5U~55S@s70£";
		var token = Web.getClientHeader("token");

		if (acptToken == token)
		{
			if (FileSystem.exists(filePath))
			{
				var value = File.getContent(filePath);
				json = Json.parse(value);
				
				var len:Int = json.leaderboardData.length;
				Lib.print("<h2>" + json.leaderboardData.length + " pieces of data found</h2>");
				
				Table.connect();
				
				for (i in 0...len)
				{
					var gameData = new GameData();
					
					gameData.id = json.leaderboardData[i].ID;
					gameData.username = json.leaderboardData[i].Username;
					gameData.countryA2 = json.leaderboardData[i].Country;
					gameData.scoreFor = json.leaderboardData[i].Scored;
					gameData.scoreAgainst = json.leaderboardData[i].Conceded;
					gameData.scoreDifference = json.leaderboardData[i].Score;
					gameData.ts = json.leaderboardData[i].TS;
					
					gameData.insert();
				}
			
				Table.disconnect();
					
				Lib.print("<h2>Restored the backup data</h2>");

			}
			else
			{
				Lib.print("<h2>Backup does not exist</h2>");
				return;
			}
		}
		else
		{
			Lib.print("<h2>You are not authorised to make a restore</h2>");
		}
	}
}