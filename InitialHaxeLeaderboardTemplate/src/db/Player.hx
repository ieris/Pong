package db;

import sys.db.Object;
import sys.db.Types;

 class Player extends Object {
	 public var id : SId;
	 public var name : SString<32>;
	 public var location : SString<32>;
 } 