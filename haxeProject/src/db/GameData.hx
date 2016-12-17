package db;

import sys.db.Object;
import sys.db.Types;

/**
 * ...
 * @author Andrew Finlay
 */

 
 /**
 * Class that only declares what types of variables that the player will have.
 * Ranges from their username to their IP and the date of the submit data.
 */
class GameData extends Object
{
	public var id:SId;
	public var username:SString<32>;
	public var countryA2:SString<32>;
	public var scoreFor:SInt;
	public var scoreAgainst:SInt;
	public var scoreDifference:SInt;
	public var ts:SDateTime;
	public var ip:SString<32>;
}