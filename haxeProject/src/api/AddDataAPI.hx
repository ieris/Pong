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
		
		var now0	= Date.now().getFullYear();
		var now1 	= Date.now().getMonth() + 1;
		var now2	= Date.now().getDate();
		var now3	= Date.now().getHours();
		var now4	= Date.now().getMinutes();
		var now5	= Date.now().getSeconds();
		
		var UTCNow = DateTools.makeUtc(now0, now1, now2, now3, now4, now5);
		
		var allow0 	= allowTime.getFullYear();
		var allow1 	= allowTime.getMonth() + 1;
		var allow2 	= allowTime.getDate();
		var allow3  = allowTime.getHours();
		var allow4 	= allowTime.getMinutes();
		var allow5 	= allowTime.getSeconds();
		
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
				
				Lib.print("<h2>Token valid<br>JSON parsed<br>Data added</h2>");
				
				BackUpAPI.backupData();
			}
			else 
			{
				Lib.print("<h2>You are not authorised</h2>");
			}
		}
		else
		{
			Lib.print("<h2>Preventing mass submission! Please wait.</h2>");
		}
		
	}
}