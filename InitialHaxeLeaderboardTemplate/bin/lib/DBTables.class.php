<?php

// Generated by Haxe 3.3.0
class DBTables {
	public function __construct(){}
	public function connect() {
		$cnx = sys_db_Mysql::connect(_hx_anonymous(array("host" => "localhost", "port" => 80, "user" => "root", "pass" => "", "database" => "leaderboard", "socket" => null)));
		sys_db_Manager::set_cnx($cnx);
		sys_db_Manager::initialize();
		sys_db_Manager::cleanup();
		sys_db_Manager::$cnx->close();
	}
	public function createTables() {
		$tmp = !sys_db_TableCreate::exists(Player::$manager);
		if($tmp) {
			sys_db_TableCreate::create(Player::$manager, null);
		}
		$tmp1 = !sys_db_TableCreate::exists(Score::$manager);
		if($tmp1) {
			sys_db_TableCreate::create(Score::$manager, null);
		}
	}
	function __toString() { return 'DBTables'; }
}