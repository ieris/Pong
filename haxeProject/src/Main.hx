package;

import api.BackUpAPI;
import api.DisplayAPI;
import api.AddDataAPI;
import api.RemoveDataAPI;
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
	
	/**
	* The main function that the index.php will call.
	* The function itself only calls the routing function.
	*/
	static function main() 
	{
		routing();
	}
	
	/**
	* This function is used to handle all of the HTML requests, it will take the URL and 
	* and then check for what the user types, for instance, /createTable will call the 
	* create table functions.
	*/
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
		
		else if (d.parts[len - 1] == "parseData")
		{
			new AddDataAPI().parseData();
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
		
		else if (d.parts[len - 1] == "displayYearAll")
		{
			DisplayAPI.displayYearAll();
		}
		
		else if (d.parts[len - 1] == "displayMonth")
		{
			DisplayAPI.displayMonth();
		}
		
		else if (d.parts[len - 1] == "displayMonthAll")
		{
			DisplayAPI.displayMonthAll();
		}
		
		else if (d.parts[len - 1] == "displayWeek")
		{
			DisplayAPI.displayWeek();
		}
		
		else if (d.parts[len - 1] == "displayWeekAll")
		{
			DisplayAPI.displayWeekAll();
		}
		
		else if (d.parts[len - 1] == "displayDay")
		{
			DisplayAPI.displayDay();
		}
		
		else if (d.parts[len - 1] == "displayDayAll")
		{
			DisplayAPI.displayDayAll();
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
		
		else if (d.parts[len - 1] == "returnUsername")
		{
			userInputString = userInput.get("username");
			ReturnAPI.returnUsername(userInputString);
		}
		
		else if (d.parts[len - 1] == "removeData")
		{
			RemoveDataAPI.deleteData();
		}
		
		else if (d.parts[len - 1] == "backupData")
		{
			BackUpAPI.backupData();
		}
		
		else if (d.parts[len - 1] == "restoreData")
		{
			BackUpAPI.restoreData();
		}
		
		else 
		{
			Lib.print("<h2>You requested something else</h2>");
		}
	}
}