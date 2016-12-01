package api;
import php.Lib;
import sys.db.Manager;
import sys.db.Mysql;
import sys.db.Types;
import haxe.Json;
import sys.io.File;

/**
 * ...
 * @author ...
 */

class ReturnAPI 
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
	
	public static function returnAll()
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

		var	req = cnx.request("SELECT * FROM GameData");
		
		for (row in req)
		{
			data.leaderboardData.push({Username: row.username, Country: row.countryA2, Score: row.scoreDifference, TS: convertToHaxeDateTime(row.ts)});
		}
		
		JSON = Json.stringify(data);
			
		Lib.print(JSON);
	}
	
	public static function returnTop10()
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

		var	req = cnx.request("SELECT * FROM GameData ORDER by scoreDifference DESC LIMIT 10");
		
		for (row in req)
		{
			data.leaderboardData.push({Username: row.username, Country: row.countryA2, Score: row.scoreDifference, TS: convertToHaxeDateTime(row.ts)});
		}
		
		JSON = Json.stringify(data);
			
		Lib.print(JSON);
	}
	
	public static function returnCountry(country:String)
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
		
		var req = cnx.request("SELECT * FROM GameData WHERE countryA2='" + country + "' ORDER by scoreDifference DESC LIMIT 10");
		
		for (row in req)
		{
			data.leaderboardData.push({Username: row.username, Country: row.countryA2, Score: row.scoreDifference, TS: convertToHaxeDateTime(row.ts)});
		}
		
		JSON = Json.stringify(data);
			
		Lib.print(JSON);
	}
	
	public static function returnYear(year:String)
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

		if (year == "now")
		{
			var req = cnx.request("SELECT * FROM GameData WHERE ts LIKE '" + (Date.now().getFullYear()) + "-%' ORDER by scoreDifference DESC LIMIT 10");
			
			for (row in req)
			{
				data.leaderboardData.push({Username: row.username, Country: row.countryA2, Score: row.scoreDifference, TS: convertToHaxeDateTime(row.ts)});
			}
		}
		else 
		{
			var req = cnx.request("SELECT * FROM GameData WHERE ts LIKE '" + year + "-%' ORDER by scoreDifference DESC LIMIT 10");
			
			for (row in req)
			{
				data.leaderboardData.push({Username: row.username, Country: row.countryA2, Score: row.scoreDifference, TS: convertToHaxeDateTime(row.ts)});
			}
		}

		JSON = Json.stringify(data);
			
		Lib.print(JSON);
	}
	
	public static function returnMonth(year:String, month:String)
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
		
		if (month == "now")
		{
			if ((Date.now().getMonth() + 1) < 10)
			{
				var req = cnx.request("SELECT * FROM GameData WHERE ts LIKE '" + Date.now().getFullYear() + "-0" + (Date.now().getMonth() + 1) + "-%' ORDER by scoreDifference DESC LIMIT 10");
				
				for (row in req)
				{
					data.leaderboardData.push({Username: row.username, Country: row.countryA2, Score: row.scoreDifference, TS: convertToHaxeDateTime(row.ts)});
				}
			}
			else 
			{
				var req = cnx.request("SELECT * FROM GameData WHERE ts LIKE '" + Date.now().getFullYear() + "-" + (Date.now().getMonth() + 1) + "-%' ORDER by scoreDifference DESC LIMIT 10");
				
				for (row in req)
				{
					data.leaderboardData.push({Username: row.username, Country: row.countryA2, Score: row.scoreDifference, TS: convertToHaxeDateTime(row.ts)});
				}
			}
		}
		else 
		{
			if (cast(month, Int) < 10)
			{
				var req = cnx.request("SELECT * FROM GameData WHERE ts LIKE '" + year + "-0" + month + "-%' ORDER by scoreDifference DESC LIMIT 10");
				
				for (row in req)
				{
					data.leaderboardData.push({Username: row.username, Country: row.countryA2, Score: row.scoreDifference, TS: convertToHaxeDateTime(row.ts)});
				}
			}
			else
			{
				var req = cnx.request("SELECT * FROM GameData WHERE ts LIKE '" + year + "-" + month + "-%' ORDER by scoreDifference DESC LIMIT 10");
				
				for (row in req)
				{
					data.leaderboardData.push({Username: row.username, Country: row.countryA2, Score: row.scoreDifference, TS: convertToHaxeDateTime(row.ts)});
				}
			}
		}
		
		JSON = Json.stringify(data);
			
		Lib.print(JSON);
	}
	
	public static function returnWeek()
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
		
		var req = cnx.request("SELECT * FROM GameData WHERE ts BETWEEN '" + Date.fromTime(Date.now().getTime()-7*24*3600*1000).toString() + "' AND '" + Date.now().toString() + "' ORDER by scoreDifference DESC LIMIT 10");
		
		for (row in req)
		{
			data.leaderboardData.push({Username: row.username, Country: row.countryA2, Score: row.scoreDifference, TS: convertToHaxeDateTime(row.ts)});
		}
		
		JSON = Json.stringify(data);
			
		Lib.print(JSON);
	}
	
	public static function returnDay(year:String, month:String, day:String)
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
		
		if (day == "now")
		{
			if ((Date.now().getMonth() + 1) < 10)
			{
				if (Date.now().getDate() < 10)
				{
					var req = cnx.request("SELECT * FROM GameData WHERE ts LIKE '" + Date.now().getFullYear() + "-0" + (Date.now().getMonth() + 1) + "-0" + (Date.now().getDate()) + "%' ORDER by scoreDifference DESC LIMIT 10");
					
					for (row in req)
					{
						data.leaderboardData.push({Username: row.username, Country: row.countryA2, Score: row.scoreDifference, TS: convertToHaxeDateTime(row.ts)});
					}
				}
				else 
				{
					var req = cnx.request("SELECT * FROM GameData WHERE ts LIKE '" + Date.now().getFullYear() + "-0" + (Date.now().getMonth() + 1) + "-" + (Date.now().getDate()) + "%' ORDER by scoreDifference DESC LIMIT 10");
					
					for (row in req)
					{
						data.leaderboardData.push({Username: row.username, Country: row.countryA2, Score: row.scoreDifference, TS: convertToHaxeDateTime(row.ts)});
					}
				}
			}
			else
			{
				if (Date.now().getDate() < 10)
				{
					var req = cnx.request("SELECT * FROM GameData WHERE ts LIKE '" + Date.now().getFullYear() + "-" + (Date.now().getMonth() + 1) + "-0" + (Date.now().getDate()) + "%' ORDER by scoreDifference DESC LIMIT 10");
					
					for (row in req)
					{
						data.leaderboardData.push({Username: row.username, Country: row.countryA2, Score: row.scoreDifference, TS: convertToHaxeDateTime(row.ts)});
					}
				}
				else 
				{
					var req = cnx.request("SELECT * FROM GameData WHERE ts LIKE '" + Date.now().getFullYear() + "-" + (Date.now().getMonth() + 1) + "-" + (Date.now().getDate()) + "%' ORDER by scoreDifference DESC LIMIT 10");
					
					for (row in req)
					{
						data.leaderboardData.push({Username: row.username, Country: row.countryA2, Score: row.scoreDifference, TS: convertToHaxeDateTime(row.ts)});
					}
				}
			}
		}
		else 
		{
			if (cast(month, Int) < 10)
			{
				if (cast(day, Int) < 10)
				{
					var req = cnx.request("SELECT * FROM GameData WHERE ts LIKE '" + year + "-0" + month + "-0" + day + "%' ORDER by scoreDifference DESC LIMIT 10");
					
					for (row in req)
					{
						data.leaderboardData.push({Username: row.username, Country: row.countryA2, Score: row.scoreDifference, TS: convertToHaxeDateTime(row.ts)});
					}
				}
				else 
				{
					var req = cnx.request("SELECT * FROM GameData WHERE ts LIKE '" + year + "-0" + month + "-" + day + "%' ORDER by scoreDifference DESC LIMIT 10");
					
					for (row in req)
					{
						data.leaderboardData.push({Username: row.username, Country: row.countryA2, Score: row.scoreDifference, TS: convertToHaxeDateTime(row.ts)});
					}
				}
			}
			else
			{
				if (cast(day, Int) < 10)
				{
					var req = cnx.request("SELECT * FROM GameData WHERE ts LIKE '" + year + "-" + month + "-0" + day + "%' ORDER by scoreDifference DESC LIMIT 10");
					
					for (row in req)
					{
						data.leaderboardData.push({Username: row.username, Country: row.countryA2, Score: row.scoreDifference, TS: convertToHaxeDateTime(row.ts)});
					}
				}
				else 
				{
					var req = cnx.request("SELECT * FROM GameData WHERE ts LIKE '" + year + "-" + month + "-" + day + "%' ORDER by scoreDifference DESC LIMIT 10");
					
					for (row in req)
					{
						data.leaderboardData.push({Username: row.username, Country: row.countryA2, Score: row.scoreDifference, TS: convertToHaxeDateTime(row.ts)});
					}
				}
			}
		}
			
		JSON = Json.stringify(data);
			
		Lib.print(JSON);
	}
}