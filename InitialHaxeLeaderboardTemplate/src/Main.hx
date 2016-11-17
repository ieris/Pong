package;

import api.PlayerApi;
import db.DBTables;
import db.Player;
import php.Web;
import haxe.web.Dispatch;
import php.Lib;

class Main {

	static function main() {
		
		routing();
		
	}
	
	static function routing(){
		
		var d = new Dispatch(Web.getURI(), Web.getParams());
		var len : Int = d.parts.length;
		var i : Int = 0;
		
		if (d.parts[len - 1] == "createTables") {
			DBTables.connect();
			DBTables.createTables();
			DBTables.disconnect();
		}
		
		else if (d.parts[len - 1] == "addPlayer") {
			new PlayerApi().addPlayer();
		}
		
		else 
		{
			Lib.print("You requested something else.");
		}
	}
}