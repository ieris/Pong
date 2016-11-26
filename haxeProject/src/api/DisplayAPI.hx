package api;
import php.Lib;
import sys.db.Manager;
import sys.db.Mysql;
import sys.db.Types;

/**
 * ...
 * @author Andrew Finlay
 */
class DisplayAPI 
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

	public static function queryLeaderboard(query:String)
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
		
		var req = cnx.request(query);
		
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
	
	public static function displayAll()
	{
		var query:String = "SELECT * FROM gamedata";
		Lib.print(query);
		queryLeaderboard(query);
	}
	
	public static function displayTop10()
	{
		var query:String = "SELECT * FROM gamedata ORDER by scoreDifference DESC LIMIT 10";
		Lib.print(query);
		queryLeaderboard(query);
	}
	
	public static function displayCountry(country:String)
	{
		var query:String = "SELECT * FROM gamedata WHERE countryA2='" + country + "' ORDER by scoreDifference DESC LIMIT 10";
		Lib.print(query);
		queryLeaderboard(query);
	}
	
	public static function displayYear(year:String)
	{
		var query:String = "SELECT * FROM gamedata WHERE ts LIKE '" + year + "-%' ORDER by scoreDifference DESC LIMIT 10";
		Lib.print(query);
		queryLeaderboard(query);
	}
	
	public static function displayMonth(month:String)
	{
		var query:String = "SELECT * FROM gamedata WHERE ts LIKE '%-" + month + "-%' ORDER by scoreDifference DESC LIMIT 10";
		Lib.print(query);
		queryLeaderboard(query);
	}
	
	//=============== NEEDS WORK - HAVING ISSUE WITH QUERIES ===============
	public static function displayWeek()
	{
		var dateNow:Date = Date.now();
		var sevenAgo:Int = dateNow.getDate() - 7;
		var sixAgo:Int = dateNow.getDate() - 6;
		var fiveAgo:Int = dateNow.getDate() - 5;
		var fourAgo:Int = dateNow.getDate() - 4;
		var threeAgo:Int = dateNow.getDate() - 3;
		var twoAgo:Int = dateNow.getDate() - 2;
		var oneAgo:Int = dateNow.getDate() - 1;
		
		var query:String = "SELECT * FROM gamedata WHERE ts LIKE '%-" + oneAgo + "%' ORDER by scoreDifference DESC LIMIT 10";
		Lib.print(query);
		queryLeaderboard(query);
	}
	
	public static function displayDay(day:String)
	{
		var query:String = "SELECT * FROM gamedata WHERE ts LIKE '%-" + day + "%' ORDER by scoreDifference DESC LIMIT 10";
		Lib.print(query);
		queryLeaderboard(query);
	}
}