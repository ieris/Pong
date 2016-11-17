package db;

import php.Lib;
import sys.db.Manager;
import sys.db.TableCreate;

class DBTables {
	 
	public static function connect(){
		 
		 var cnx = sys.db.Mysql.connect({
			 host : "localhost",
			 port : 3306,
			 user : "root",
			 pass : "",
			 database : "lead", 
			 socket : null,
			 
		 });
		 
		 Manager.cnx = cnx;
		 Manager.initialize();

	 }
	 
	 public static function disconnect(){
		 Manager.cleanup();
		 Manager.cnx.close();
	 }
	 
	 public static function createTables(){
		 if (!TableCreate.exists(Player.manager)){
			 TableCreate.create(Player.manager);
		 }
		 if (!TableCreate.exists(Score.manager)){
			 TableCreate.create(Score.manager);
		 }
		 
		 Lib.print("<h1>Successful</h1>");
	 }
}