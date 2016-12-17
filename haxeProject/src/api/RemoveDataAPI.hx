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
	
	/**
	 * This function will allow for the deletion of data via a custom query.
	 * A get param is used to get the information to delete and how to delete it,
	 * for instance "ID=23". A HTTP header is used for authenticaiton to ensure that
	 * only the game (that is setting the header) is able to delete the data as you
	 * do not want the players of the game doing this by themselves. If the token is
	 * accepted, it will connect to the database and run the custom delete SQL query.
	 */
	public static function deleteData()
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
			
			Lib.print("<h2>Deleted data</h2>");
		}
		else 
		{
			Lib.print("<h2>You are not authorised to delete data</h2>");
		}
	}
}