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
	
	/**
	 * To backup the data, a connection is made to the database, and the declaration of a JSON array is made,
	 * the SQL query gets all the data from the table and then all of the data in that table is then pushed back
	 * into the array. This JSON array is then stringified and saved locally as "backup.json". This will save the
	 * file in the Coventry.domains file manager where the index.php file is. A confirmation message is then printed.
	 */
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
			data.leaderboardData.push({ID: row.id, Username: row.username, Country: row.countryA2, Scored: row.scoreFor, Conceded: row.scoreAgainst, Score: row.scoreDifference, TS: row.ts, IP: row.ip});
		}
		
		JSON = Json.stringify(data);
		
		var filePath = "backup.json";
		File.saveContent(filePath, JSON);
		
		Lib.print("<h2>Backup file created</h2>");

	}
	
	/**
	 * To restore the data, first the file path of the file is declared along with the JSON of a dynamic type to be able 
	 * to get the length. Another HTTP header authentication is implemented like before. If the token is accepted and the
	 * file exists, then take the length of the JSON array and iterate from 0 to the length to ensure that all of the data
	 * from the JSON file is inserted into the database. Some checks and error messages are then printed.
	 */
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
					gameData.ip = json.leaderboardData[i].IP;
					
					gameData.insert();
				}
			
				Table.disconnect();
					
				Lib.print("<h2>Restored data</h2>");

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