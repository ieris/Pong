package db;

import sys.db.Object;
import sys.db.Types.SId;
import sys.db.Types.SInt;
import sys.db.Types.SString;

/**
 * ...
 * @author Andrew Finlay
 */

class GameData extends Object {

	public var id : SId;
	public var username : SString<32>;
	public var countryA2 : SString<32>;
	public var scoreFor : SInt;
	public var scoreAgainst : SInt;
	public var scoreDifference : SInt;
}