package api;
import db.DBTables;
import db.Player;
import php.Lib;
import php.Web;

/**
 * ...
 * @author Andrew
 */
class PlayerApi 
{
	
	public function new(){
		
	}

	public function addPlayer(){
		
		var p = new Player();
		
		var data = Web.getParams();
		
		p.name = data.get("name");
		p.location = data.get("location");
		
		DBTables.connect();
		p.insert();
		DBTables.disconnect();
		
		Lib.print("Added a player");
		
	}
	
}