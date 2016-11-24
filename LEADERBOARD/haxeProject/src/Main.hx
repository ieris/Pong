package;

import api.GameDataAPI;
import db.Tables;
import haxe.web.Dispatch;
import php.Lib;
import php.Web;

/**
 * ...
 * @author Andrew Finlay
 */
class Main {

	static function main() {
		routing();
	}
	
	static function routing() {
		var d = new Dispatch(Web.getURI(), Web.getParams());
		var len : Int = d.parts.length;
		var i : Int = 0;
		
		if (d.parts[len - 1] == "createTables"){
			Tables.connect();
			Tables.createTables();
			Tables.disconnect();
		}
		
		else if (d.parts[len - 1] == "addData") {
			new GameDataAPI().addData();
		}
		
		else if (d.parts[len - 1] == "test"){
			Lib.print("<h2>Testing connection</h2>");
		}
		
		else if (d.parts[len - 1] == "displayLeaderboard") {
			Tables.displayLeaderboard();
		}
		
		else {
			Lib.print("<h2>You requested something else</h2>");
		}
	}

}