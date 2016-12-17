package db;
import php.Lib;
import sys.db.Manager;
import sys.db.Mysql;
import sys.db.TableCreate;

/**
 * ...
 * @author Andrew Finlay
 */

class Table 
{
	
	/**
	 * This will connect to the database that is created on the Coventry 
	 * domains website and initialise the connection and the manager.
	 */
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
	
	/**
	 * Disconnected from the table by cleaning up the manager  
	 * and closing the connection.
	 */
	public static function disconnect()
	{
		Manager.cleanup();
		Manager.cnx.close();
	}
	
	/**
	 *  Check if there is a table, if a table does not exist then create
	 *  a table and print a message that such an action has happened.
	 */
	public static function createTable() 
	{
		if (!TableCreate.exists(GameData.manager)) 
		{
			TableCreate.create(GameData.manager);
		}
		
		Lib.print("<h2>Table created</h2>");
	}
}