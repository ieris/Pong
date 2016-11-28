package;

import api.DisplayAPI;
import api.GameDataAPI;
import db.Table;
import haxe.web.Dispatch;
import php.Lib;
import php.Web;

/**
 * ...
 * @author Andrew Finlay
 */

class Main 
{
	static function main() 
	{
		routing();
	}
	
	static function routing()
	{
		var d = new Dispatch(Web.getURI(), Web.getParams());
		var len:Int = d.parts.length;
		var userInput = Web.getParams();
		var userInputString:String;
		
		if (d.parts[len - 1] == "createTable")
		{
			Table.connect();
			Table.createTable();
			Table.disconnect();
		}
		
		else if (d.parts[len - 1] == "addData") 
		{
			new GameDataAPI().addData();
		}
		
		else if (d.parts[len - 1] == "displayAll")
		{
			DisplayAPI.displayAll();
		}
		
		else if (d.parts[len - 1] == "displayTop10")
		{
			DisplayAPI.displayTop10();
		}
		
		else if (d.parts[len - 1] == "displayCountry")
		{
			userInputString = userInput.get("country");
			DisplayAPI.displayCountry(userInputString);
		}
		
		else if (d.parts[len - 1] == "displayYear")
		{
			DisplayAPI.displayYear();
		}
		
		else if (d.parts[len - 1] == "displayMonth")
		{
			DisplayAPI.displayMonth();
		}
		
		else if (d.parts[len - 1] == "displayWeek")
		{
			DisplayAPI.displayWeek();
		}
		
		else if (d.parts[len - 1] == "displayDay")
		{
			DisplayAPI.displayDay();
		}
		
		else if (d.parts[len - 1] == "customDay")
		{
			userInputString = userInput.get("day");
			DisplayAPI.displayCustomDay(userInputString);
		}
		
		else if (d.parts[len - 1] == "createJSON")
		{
			DisplayAPI.createJSON();
		}
		
		else 
		{
			Lib.print("<h2>You requested something else</h2>");
		}
	}
}