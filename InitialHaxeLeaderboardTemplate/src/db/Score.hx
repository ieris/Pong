package db;

import sys.db.Object;
import sys.db.Types;

 class Score extends Object {
	 public var id : SId;
	 public var value : SFloat;
	 public var date : SDateTime;
	
	 
	 @:relation(playerId) public var player : Player;

 }