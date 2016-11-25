package db;
import php.Lib;
import sys.db.Manager;
import sys.db.Mysql;
import sys.db.TableCreate;
import sys.db.Types;

/**
 * ...
 * @author Andrew Finlay
 */

class Table 
{
	public static function connect()
	{
		var cnx = Mysql.connect
		({
			host : "localhost",
			port : 3306,
			user : "root",
			pass : "",
			database : "leaderboard",
			socket : null,
		});
		
		Manager.cnx = cnx;
		Manager.initialize();
	}
	
	public static function disconnect()
	{
		Manager.cleanup();
		Manager.cnx.close();
	}
	
	public static function createTable() 
	{
		if (!TableCreate.exists(GameData.manager)) 
		{
			TableCreate.create(GameData.manager);
		}
		
		Lib.print("<h2>Table created</h2>");
	}
	
	public static function convertToHaxeDateTime(s_date:SDateTime):Date 
	{
		var t_date:String;

		t_date = s_date.getFullYear() + "-" + (s_date.getMonth() + 1) + "-" + s_date.getDate() + " " + s_date.getHours() + ":" + s_date.getMinutes() + ":" + s_date.getSeconds();

		return Date.fromString(t_date);
	}

	public static function displayLeaderboard() 
	{
		var cnx = Mysql.connect
		({
			
			host : "localhost",
			port : 3306,
			user : "root",
			pass : "",
			database : "leaderboard",
			socket : null,
			
		});
	
		
		//GET ALL DATA BY DEFAULT
		//var req = cnx.request("SELECT * FROM gamedata");
		
		//GET TOP 10 SCORES
		var req = cnx.request("SELECT * FROM gamedata ORDER by scoreDifference DESC LIMIT 10");
		
		//GET TOP 10 SCORES FROM A COUNTRY
		//var req = cnx.request("SELECT * FROM gamedata WHERE countryA2='GB' ORDER by scoreDifference DESC LIMIT 10");
		
		//GET TOP 10 SCORES FROM A GIVEN YEAR
		//var req = cnx.request("SELECT * FROM gamedata WHERE ts LIKE '2015-%' ORDER by scoreDifference DESC LIMIT 10");
		
		//GET TOP 10 SCORES FROM A GIVEN MONTH
		//var req = cnx.request("SELECT * FROM gamedata WHERE ts LIKE '%-12-%' ORDER by scoreDifference DESC LIMIT 10");
		
		//GET TOP 10 SCORES FROM A GIVEN DAY
		//var req = cnx.request("SELECT * FROM gamedata WHERE ts LIKE '%-25%' ORDER by scoreDifference DESC LIMIT 10");
		
		Lib.print(
		"<body>" +
		"<table border=1; cellpadding=4; cellspacing=0; style=border-collapse:collapse; bordercolor=f67ffff;>" + 
		"<tr>" +
		"<th style=background-color:#019e9e><font style=font-family:Verdana; color=white>RANK</font></th>" + 
		"<th style=background-color:#019e9e><font style=font-family:Verdana; color=white>USERNAME</font></th>" + 
		"<th style=background-color:#019e9e><font style=font-family:Verdana; color=white>COUNTRY</font></th>" +
		"<th style=background-color:#019e9e><font style=font-family:Verdana; color=white>SCORE</font></th>" +
		"<th style=background-color:#019e9e><font style=font-family:Verdana; color=white>TIMESTAMP</font></th>" +
		"<th style=background-color:#019e9e><font style=font-family:Verdana; color=white>ID</font></th>"
		);
		
		var i:Int = 1;
		
		for (row in req) 
		{
			Lib.print(
			"<tr>" +
			"<td style=background-color:#006666><font style=font-family:Verdana; color=white>" + i + "</font></td>" +
			"<td style=background-color:#006666><font style=font-family:Verdana; color=white>" + row.username + "</font></td>" + 
			"<td style=background-color:#006666><font style=font-family:Verdana; color=white>" + row.countryA2 + "</font></td>" + 
			"<td style=background-color:#006666><font style=font-family:Verdana; color=white>" + row.scoreDifference + "</font></td>" +
			"<td style=background-color:#006666><font style=font-family:Verdana; color=white>" + convertToHaxeDateTime(row.ts) + "</font></td>" +
			"<td style=background-color:#006666><font style=font-family:Verdana; color=white>" + row.id + "</font></td>" +
			"</tr>"
			);
			
			i++;
		}
		
		Lib.print("</table></body>");
	}
}