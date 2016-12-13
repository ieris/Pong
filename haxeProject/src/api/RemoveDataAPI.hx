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
		var params = Web.getParams();
		var query = params.get("query");
		
		var acptToken = "$/>?&ReqEQjs7ih";
		var token = Web.getClientHeader("token");
		
		if (token == acptToken)
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

			var	req = cnx.request("DELETE FROM GameData WHERE " + query);
			
			Lib.print("<h2>Your query: " + "DELETE FROM GameData WHERE " + query + "<br>Deleted data!</h2>");
		}
		else 
		{
			Lib.print("<h2>You are not authorised to delete data</h2>");
		}
	}
}