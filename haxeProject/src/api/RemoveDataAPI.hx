package api;
import haxe.Json;
import php.Lib;
import php.Web;
import sys.db.Mysql;

/**
 * ...
 * @author Andrew Finlay
 */

class RemoveDataAPI 
{
	public function new() 
	{
		
	}
	
	public static function deleteData(id:String)
	{
		var token = "[T0'f7`83WYOtA,";
		var params = Web.getParams();
		var jsonStringData = params.get("query");
		var jsonObj = Json.parse(jsonStringData);
		
		var cnx = Mysql.connect
		({
			host : "localhost",
			port : 3306,
			user : "andrewco_admin",
			pass : "Ican£tthink",
			database : "andrewco_leaderboard",
			socket : null,
		}); 
		
		if (jsonObj.token == token)
		{
			var	req = cnx.request(jsonObj.query);
			
			Lib.print("<h2>Query: " + jsonObj.query + "<br>Deleted data</h2>");
		}
		else 
		{
			Lib.print("<h2>Token invalid</h2");
		}
	}
}