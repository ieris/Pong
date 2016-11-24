package db;
import php.Lib;
import sys.db.Manager;
import sys.db.Mysql;
import sys.db.TableCreate;

/**
 * ...
 * @author Andrew Finlay
 */

class Tables {

	public static function connect() {
		
		var cnx = Mysql.connect( {
			
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
	
	public static function disconnect(){
		Manager.cleanup();
		Manager.cnx.close();
	}
	
	public static function createTables() {
		if (!TableCreate.exists(GameData.manager)) {
			TableCreate.create(GameData.manager);
		}
		
		Lib.print("<h2>Table created</h2>");
	}
	
	public static function displayLeaderboard() {
		
		var cnx = Mysql.connect( {
			
			host : "localhost",
			port : 3306,
			user : "root",
			pass : "",
			database : "leaderboard",
			socket : null,
			
		});
	
		var req = cnx.request("SELECT * FROM gamedata ORDER by scoreDifference DESC LIMIT 10");
	
		for (row in req) {
			Lib.print(" || Username: " + row.username + " || Country: " + row.countryA2 + " || Score: " + row.scoreDifference + "<br>");
		}
	}
}