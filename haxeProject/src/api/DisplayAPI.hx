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
		"<table cellpadding=4; cellspacing=0>" +
		"<tr>" +
		"<th><font color=white><a href='/displayAll'>" + "All" + "</a></font></th>" +
		"<th><font color=white><a href='/displayTop10'>" + "Top 10" + "</a></font></th>" +
		
		"<th><font color=white><select onChange='window.location.href=this.value'>" + 
		"<option value=''>Country</option>" +
		"<option value='/displayCountry?country=GB'>GB</option>" + 
		"<option value='displayCountry?country=IN'>IN</option>" +
		"<option value='displayCountry?country=IT'>IT</option>" +
		"<option value='displayCountry?country=LT'>LT</option>" +
		"</select></font></th>" +
		
		"<th><font color=white><select onChange='window.location.href=this.value'>" + 
		"<option value=''>Year</option>" +
		"<option value='/displayYear?year=2016'>2016</option>" + 
		"<option value='/displayYear?year=2015'>2015</option>" +
		"<option value='/displayYear?year=2014'>2014</option>" +
		"<option value='/displayYear?year=2013'>2013</option>" +
		"</select></font></th>" +
		
		"<th><font color=white><select onChange='window.location.href=this.value'>" + 
		"<option value=''>Month</option>" +
		"<option value='/displayMonth?month=12'>12</option>" + 
		"<option value='/displayMonth?month=11'>11</option>" +
		"<option value='/displayMonth?month=10'>10</option>" +
		"<option value='/displayMonth?month=9'>9</option>" +
		"</select></font></th>" +
		
		"<th><font color=white><a href='/displayWeek'>" + "This Week" + "</a></font></th>" +
	
		"<th><font color=white><a href='/displayDay?day=24'>" + "Today" + "</a></font></th>" +
		"</tr></table>" +
		
		"<table border=1; cellpadding=4; cellspacing=0; style=border-collapse:collapse; bordercolor=f67ffff>" + 
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
	
	public static function displayWeek()
	{	
		var dateNow:Date = Date.now();
		var query:String = "SELECT * FROM gamedata WHERE ts BETWEEN '" + Date.fromTime(dateNow.getTime()-7*24*3600*1000).toString() + "' AND '" + dateNow.toString() + "' ORDER by scoreDifference DESC LIMIT 10";
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