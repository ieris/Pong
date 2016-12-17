package api;

import php.Lib;
import php.Web;
import sys.db.Manager;
import sys.db.Mysql;
import sys.db.Types;
import haxe.Json;
import sys.io.File;

/**
 * ...
 * @author Andrew Finlay
 */

class ReturnAPI 
{
	public function new() 
	{
		
	}
	
	/**
	 * Function that will return a haxe date based of converting a SQL date.
	 * Take the date as a string and convert it from SDateTime to Date.
	 */
	public static function convertToHaxeDateTime(s_date:SDateTime):Date 
	{
		var t_date:String;

		t_date = s_date.getFullYear() + "-" + (s_date.getMonth() + 1) + "-" + s_date.getDate() + " " + s_date.getHours() + ":" + s_date.getMinutes() + ":" + s_date.getSeconds();

		return Date.fromString(t_date);
	}
	
	/**
	 * Connect to the database and create a JSON array, pushing back the data
	 * then print out a stringified version of this data for the game to use.
	 * The SQL query is just taking all the data from the table.
	 */
	public static function returnAll()
	{
		var cnx = Mysql.connect
		({
			port : 3306,
			host : "localhost",
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
	
	/**
	 * Connect to the database and create a JSON array, pushing back the data
	 * then print out a stringified version of this data for the game to use.
	 * The SQL query is just taking all the data from the table, ordering it
	 * by the score they get and limiting to only the top 10 players
	 */
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
	
	/**
	 * Connect to the database and create a JSON array, pushing back the data
	 * then print out a stringified version of this data for the game to use.
	 * The SQL query is returning the data where the country is the user specified
	 * one from the get params in the main class.
	 */
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
	
	/**
	 * Connect to the database and create a JSON array, pushing back the data
	 * then print out a stringified version of this data for the game to use.
	 * The SQL query is returning the data where the year is the user specified
	 * one from the get params in the main class. It uses SQL wildcards and LIKE
	 * to find the correct year/date. If the user specified string is "now", then
	 * the database will return all the data from the current year, otherwise use
	 * the custom inputted year.
	 */
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
	
	/**
	 * Connect to the database and create a JSON array, pushing back the data
	 * then print out a stringified version of this data for the game to use.
	 * The SQL query is returning the data where the year is the user specified
	 * one from the get params in the main class. It uses SQL wildcards and LIKE
	 * to find the correct month/date. If the user specified string is "now", then
	 * the database will return all the data from the current month, otherwise use
	 * the custom inputted month. The if statements check if the value inputted is
	 * less than 0 to then put the 0 before the input. So "2" will come out as "02"
	 * as this is how SQL stores the dates.
	 */
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
	
	/**
	 * Connect to the database and create a JSON array, pushing back the data
	 * then print out a stringified version of this data for the game to use.
	 * The SQL query is returning the data where the date/time is between the 
	 * date today - 7 days and the day today. This gives the data from the current
	 * week.
	 */
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
		
		var req = cnx.request("SELECT * FROM GameData WHERE ts BETWEEN '" + Date.fromTime(Date.now().getTime()-7*24*3600*1000) + "' AND '" + Date.now() + "' ORDER by scoreDifference DESC LIMIT 10");
		
		for (row in req)
		{
			data.leaderboardData.push({Username: row.username, Country: row.countryA2, Score: row.scoreDifference, TS: convertToHaxeDateTime(row.ts)});
		}
		
		JSON = Json.stringify(data);
			
		Lib.print(JSON);
	}
	
	/**
	 * Connect to the database and create a JSON array, pushing back the data
	 * then print out a stringified version of this data for the game to use.
	 * The SQL query is returning the data where the day is the user specified
	 * one from the get params in the main class. It uses SQL wildcards and LIKE
	 * to find the correct day/date. If the user specified string is "now", then
	 * the database will return all the data from today, otherwise use the custom
	 * day. The if statements check if the value input is less than 0, if it is, add
	 * a 0 before the day so that it will return the date correct. This is due to the
	 * fact that that SQL stores "2" as "02".
	 */
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
	
	/**
	 * Connect to the database and create a JSON array, pushing back the data
	 * then print out a stringified version of this data for the game to use.
	 * The SQL query is returning the data where the username is the one that
	 * is custom input and also where the IP is of the current IP address of 
	 * the client. This ensure that the database is returning the correct unique
	 * player.
	 */
	public static function returnUsername(username:String)
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
		
		var ip = Web.getClientIP();
		
		var req = cnx.request("SELECT * FROM GameData WHERE Username='" + username + "' AND IP='" + ip + "' ORDER by scoreDifference DESC");
					
		for (row in req)
		{
			data.leaderboardData.push({Username: row.username, Country: row.countryA2, Score: row.scoreDifference, TS: convertToHaxeDateTime(row.ts)});
		}
		
		JSON = Json.stringify(data);
		
		Lib.print(JSON);
	}
}