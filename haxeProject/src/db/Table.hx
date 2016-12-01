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
			user : "andrewco_admin",
			pass : "Ican£tthink",
			database : "andrewco_leaderboard",
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
}