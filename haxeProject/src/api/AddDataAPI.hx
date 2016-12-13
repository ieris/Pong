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
		
		//var submitTime = Date.now();
		//var allowTime = submitTime.getFullYear() + "-" + (submitTime.getMonth() + 1) + "-" + submitTime.getDate() + " " + submitTime.getHours() + ":" + submitTime.getMinutes() + ":" + ((submitTime.getSeconds()) + 10);
		//Lib.print(submitTime);
		//Lib.print("<br>");
		//Lib.print(allowTime);
		
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
			data.leaderboardData.push({TS: convertToHaxeDateTime(row.ts)});
		}

		var len:Int = data.leaderboardData.length;
		
		var lastTime = data.leaderboardData[len - 1].TS;
		
		var allowTime = Date.fromString(lastTime.getFullYear() + "-" + (lastTime.getMonth() + 1) + "-" + lastTime.getDate() + " " + lastTime.getHours() + ":" + lastTime.getMinutes() + ":" + ((lastTime.getSeconds()) + 10));
		
		if (lastTime.getSeconds() >= 50)
		{
			allowTime = Date.fromString(lastTime.getFullYear() + "-" + (lastTime.getMonth() + 1) + "-" + lastTime.getDate() + " " + lastTime.getHours() + ":" + (lastTime.getMinutes() + 1) + ":" + (lastTime.getSeconds() - 50));
		}
		
		Lib.print("Last time: " + lastTime + "<br>");
		
		Lib.print("Allow time: " + allowTime + "<br>");
		
		Lib.print("Time now: " + Date.now() + "<br>");
		
		var new0	= Date.now().getFullYear();
		var new1 	= Date.now().getMonth() + 1;
		var new2	= Date.now().getDate();
		var new3	= Date.now().getHours();
		var new4	= Date.now().getMinutes();
		var new5	= Date.now().getSeconds();
		
		var UTCNow = DateTools.makeUtc(new0, new1, new2, new3, new4, new5);
		
		var test0 	= allowTime.getFullYear();
		var test1 	= allowTime.getMonth() + 1;
		var test2 	= allowTime.getDate();
		var test3  	= allowTime.getHours();
		var test4 	= allowTime.getMinutes();
		var test5 	= allowTime.getSeconds();
		
		var UTCAllowTime = DateTools.makeUtc(test0, test1, test2, test3, test4, test5);
	
		Lib.print("Allow UTC: " + UTCAllowTime + "<br>");
		
		Lib.print("Now UTC: " + UTCAllowTime + "<br>");
		
		if (UTCNow > UTCAllowTime)
		{
			var gameData = new GameData();
			
			gameData.username = jsonObj.Username;
			gameData.countryA2 = jsonObj.Country;
			gameData.scoreFor = jsonObj.Scored;
			gameData.scoreAgainst = jsonObj.Conceded;
			gameData.scoreDifference = gameData.scoreFor - gameData.scoreAgainst;
			gameData.ts = convertToSQLDateTime(Date.now());
			
			//if (token == acptToken)
			//{
				Table.connect();
				gameData.insert();
				Table.disconnect();
				
				Lib.print("<h2>Token valid<br>JSON parsed<br>Data added</h2>");
				
				BackUpAPI.backupData();
			//}
			//else 
			//{
			//	Lib.print("<h2>You are not authorised</h2>");
			//}
		}
		else
		{
			Lib.print("<h2>Preventing mass submission! Please wait.</h2>");
		}
		
	}
}