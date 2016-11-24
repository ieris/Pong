package api;
import db.GameData;
import db.Tables;
import haxe.Json;
import php.Lib;
import php.Web;
import sys.io.File;

/**
 * ...
 * @author Andrew Finlay
 */

class GameDataAPI {

	public function new() {
		
	}
	
	public function addData() {
		
		var filePath = "C:\\University\\301CR - Advanced Games Programming\\Assignment 2\\Leaderboard\\Leaderboard\\src\\gameData.json";
		var value = File.getContent(filePath);
		var json = Json.parse(value);
	//	Lib.print("Username: " + json.Username + "<br>" + "Country: " + json.Country + "<br>" + "Scored: " + json.Scored + "<br>" + "Conceeded: " + json.Conceeded);
		
		var gameData = new GameData();
	
		gameData.username = json.Username;
		gameData.countryA2 = json.Country;
		gameData.scoreFor = json.Scored;
		gameData.scoreAgainst = json.Conceeded;
		gameData.scoreDifference = gameData.scoreFor - gameData.scoreAgainst;
		
		Tables.connect();
		gameData.insert();
		Tables.disconnect();
		
		Lib.print("<h2>Added data</h2>");
	}
	
}