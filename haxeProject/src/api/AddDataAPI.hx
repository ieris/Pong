package api;

import db.GameData;
import db.Table;
import haxe.Http;
import haxe.Json;
import haxe.io.BytesOutput;
import php.Lib;
import php.Web;
import sys.db.Types.SDateTime;
import sys.io.File;
import sys.db.Mysql;

/**
 * ...
 * @author Andrew Finlay
 */

class AddDataAPI 
{
	public function new() 
	{
		
	}
	
	/**
	 * A simple function that will convert the SQL date time to Haxe date time.
	 */
	public static function convertToHaxeDateTime(s_date:SDateTime):Date 
	{
		var t_date:String;

		t_date = s_date.getFullYear() + "-" + (s_date.getMonth() + 1) + "-" + s_date.getDate() + " " + s_date.getHours() + ":" + s_date.getMinutes() + ":" + s_date.getSeconds();

		return Date.fromString(t_date);
	}
	
	/**
	 * A simple function that will convert the haxe date time to SQL date time.
	 */
	public static function convertToSQLDateTime(h_date:Date):SDateTime 
	{
		var t_date:String;
		
		t_date = h_date.getFullYear() + "-" + (h_date.getMonth() + 1) + "-" + h_date.getDate() + " " + h_date.getHours() + ":" + h_date.getMinutes() + ":" + h_date.getSeconds();
 
		return cast(t_date, SDateTime);
	}
	
	/**
	 * In order to add data to the database, the concept of a JSON string is used. HTTP get params are used to get all of the
	 * data that is declared after "data" in the URL. This data is then parsed as a JSON to be used for later. A HTTP header
	 * is used to allow only the game that sets this header to be able to add data for authentication. A connection to the 
	 * databse is then established, data from the database is then queried to get the last time and IP address. This information
	 * is then used to prevent mass submission by adding 10 seconds to the last time and only if the current time is larger than
	 * this time by converting them both to UTC time to give a raw number that can be used for conditions. If the last IP is 
	 * different to the current one or enough time has passed, allow for the insersion of the data into the database by using 
	 * the parsed JSON stored from earlier. If the token is also allowed, connect to the database again and inser the data.
	 * A bunch of errors messages and confirmations are printed in each of the conditions.
	 */
	public function parseData()
	{
		var params = Web.getParams();
		var jsonStringData = params.get("data");
		var jsonObj = Json.parse(jsonStringData);
		
		var acptToken = "NG$c0#f5H9EL~_o";
		var token = Web.getClientHeader("token");
		
		var cnx = Mysql.connect
		({
			host : "localhost",
			port : 3306,
			user : "andrewco_admin",
			pass : "Ican£tthink",
			database : "andrewco_leaderboard",
			socket : null,
		});
		
		var req = cnx.request("SELECT * FROM GameData");
		
		var arrayOfRows = new Array();
		var data = {leaderboardData:arrayOfRows};
		
		for (row in req)
		{
			data.leaderboardData.push({TS: convertToHaxeDateTime(row.ts), IP: row.ip});
		}

		var len:Int = data.leaderboardData.length;
		
		var lastTime = data.leaderboardData[len - 1].TS;
		
		var allowTime = Date.fromString(lastTime.getFullYear() + "-" + (lastTime.getMonth() + 1) + "-" + lastTime.getDate() + " " + lastTime.getHours() + ":" + lastTime.getMinutes() + ":" + ((lastTime.getSeconds()) + 10));
		
		if (lastTime.getSeconds() >= 50)
		{
			allowTime = Date.fromString(lastTime.getFullYear() + "-" + (lastTime.getMonth() + 1) + "-" + lastTime.getDate() + " " + lastTime.getHours() + ":" + (lastTime.getMinutes() + 1) + ":" + (lastTime.getSeconds() - 50));
		}
		
		var now0 = Date.now().getFullYear();
		var now1 = Date.now().getMonth() + 1;
		var now2 = Date.now().getDate();
		var now3 = Date.now().getHours();
		var now4 = Date.now().getMinutes();
		var now5 = Date.now().getSeconds();
		
		var UTCNow = DateTools.makeUtc(now0, now1, now2, now3, now4, now5);
		
		var allow0 = allowTime.getFullYear();
		var allow1 = allowTime.getMonth() + 1;
		var allow2 = allowTime.getDate();
		var allow3 = allowTime.getHours();
		var allow4 = allowTime.getMinutes();
		var allow5 = allowTime.getSeconds();
		
		var UTCAllowTime = DateTools.makeUtc(allow0, allow1, allow2, allow3, allow4, allow5);
		
		var lastIP = data.leaderboardData[len - 1].IP;
		var currentIP = Web.getClientIP();
		
		if ((UTCNow > UTCAllowTime) || (currentIP != lastIP))
		{
			var gameData = new GameData();
			
			gameData.username = jsonObj.Username;
			gameData.countryA2 = jsonObj.Country;
			gameData.scoreFor = jsonObj.Scored;
			gameData.scoreAgainst = jsonObj.Conceded;
			gameData.scoreDifference = gameData.scoreFor - gameData.scoreAgainst;
			gameData.ts = convertToSQLDateTime(Date.now());
			gameData.ip = Web.getClientIP();
			
			if (token == acptToken)
			{
				Table.connect();
				gameData.insert();
				Table.disconnect();
				
				Lib.print("<h2>Data added</h2>");
				
				BackUpAPI.backupData();
			}
			else 
			{
				Lib.print("<h2>You are not authorised</h2>");
			}
		}
		else
		{
			Lib.print("<h2>Preventing mass submission! Please wait</h2>");
		}
		
	}
}