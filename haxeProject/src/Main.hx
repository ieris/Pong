package;

import api.DisplayAPI;
import api.GameDataAPI;
import api.ReturnAPI;
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
		var userInputString1:String;
		var userInputString2:String;
		
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
		
		else if (d.parts[len - 1] == "returnAll")
		{
			ReturnAPI.returnAll();
		}
		
		else if (d.parts[len - 1] == "returnTop10")
		{
			ReturnAPI.returnTop10();
		}
		
		else if (d.parts[len - 1] == "returnCountry")
		{
			userInputString = userInput.get("country");
			ReturnAPI.returnCountry(userInputString);
		}
		
		else if (d.parts[len - 1] == "returnYear")
		{
			userInputString = userInput.get("year");
			ReturnAPI.returnYear(userInputString);
		}
		
		else if (d.parts[len - 1] == "returnMonth")
		{
			userInputString = userInput.get("year");
			userInputString1 = userInput.get("month");
			ReturnAPI.returnMonth(userInputString, userInputString1);
		}
		
		else if (d.parts[len - 1] == "returnWeek")
		{
			ReturnAPI.returnWeek();
		}
		
		else if (d.parts[len - 1] == "returnDay")
		{
			userInputString = userInput.get("year");
			userInputString1 = userInput.get("month");
			userInputString2 = userInput.get("day");
			ReturnAPI.returnDay(userInputString, userInputString1, userInputString2);
		}
		
		else 
		{
			Lib.print("<h2>You requested something else</h2>");
		}
	}
}