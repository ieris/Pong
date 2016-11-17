<?php

// Generated by Haxe 3.3.0
class sys_db_TableCreate {
	public function __construct(){}
	static function autoInc($dbName) {
		if($dbName === "SQLite") {
			return "PRIMARY KEY AUTOINCREMENT";
		} else {
			return "AUTO_INCREMENT";
		}
	}
	static function getTypeSQL($t, $dbName) {
		$tmp = $t->index;
		switch($tmp) {
		case 0:{
			return "INTEGER " . _hx_string_or_null(sys_db_TableCreate::autoInc($dbName));
		}break;
		case 1:case 20:{
			return "INTEGER";
		}break;
		case 2:{
			return "INTEGER UNSIGNED " . _hx_string_or_null(sys_db_TableCreate::autoInc($dbName));
		}break;
		case 3:{
			return "INTEGER UNSIGNED";
		}break;
		case 4:{
			return "BIGINT " . _hx_string_or_null(sys_db_TableCreate::autoInc($dbName));
		}break;
		case 5:{
			return "BIGINT";
		}break;
		case 6:{
			return "FLOAT";
		}break;
		case 7:{
			return "DOUBLE";
		}break;
		case 8:{
			return "TINYINT(1)";
		}break;
		case 9:{
			return "VARCHAR(" . _hx_string_rec(_hx_deref($t)->params[0], "") . ")";
		}break;
		case 10:{
			return "DATE";
		}break;
		case 11:{
			return "DATETIME";
		}break;
		case 12:{
			return "TIMESTAMP DEFAULT 0";
		}break;
		case 13:{
			return "TINYTEXT";
		}break;
		case 14:{
			return "TEXT";
		}break;
		case 16:{
			return "BLOB";
		}break;
		case 17:{
			return "LONGBLOB";
		}break;
		case 18:case 22:case 30:{
			return "MEDIUMBLOB";
		}break;
		case 19:{
			return "BINARY(" . _hx_string_rec(_hx_deref($t)->params[0], "") . ")";
		}break;
		case 15:case 21:{
			return "MEDIUMTEXT";
		}break;
		case 23:{
			$auto = _hx_deref($t)->params[1];
			$fl = _hx_deref($t)->params[0];
			$tmp1 = null;
			if($auto) {
				if($fl->length <= 8) {
					$tmp1 = sys_db_RecordType::$DTinyUInt;
				} else {
					if($fl->length <= 16) {
						$tmp1 = sys_db_RecordType::$DSmallUInt;
					} else {
						if($fl->length <= 24) {
							$tmp1 = sys_db_RecordType::$DMediumUInt;
						} else {
							$tmp1 = sys_db_RecordType::$DInt;
						}
					}
				}
			} else {
				$tmp1 = sys_db_RecordType::$DInt;
			}
			return sys_db_TableCreate::getTypeSQL($tmp1, $dbName);
		}break;
		case 24:{
			return "TINYINT";
		}break;
		case 26:{
			return "SMALLINT";
		}break;
		case 27:{
			return "SMALLINT UNSIGNED";
		}break;
		case 28:{
			return "MEDIUMINT";
		}break;
		case 29:{
			return "MEDIUMINT UNSIGNED";
		}break;
		case 25:case 31:{
			return "TINYINT UNSIGNED";
		}break;
		case 32:case 33:{
			throw new HException("assert");
		}break;
		}
	}
	static function create($manager, $engine = null) {
		$quote = array(new _hx_lambda(array(&$manager), "sys_db_TableCreate_0"), 'execute');
		$cnx = $manager->getCnx();
		if($cnx === null) {
			throw new HException("SQL Connection not initialized on Manager");
		}
		$dbName = $cnx->dbName();
		$infos = $manager->dbInfos();
		$tmp = call_user_func_array($quote, array($infos->name));
		$sql = "CREATE TABLE " . _hx_string_or_null($tmp) . " (";
		$decls = (new _hx_array(array()));
		$hasID = false;
		{
			$_g = 0;
			$_g1 = $infos->fields;
			while($_g < $_g1->length) {
				$f = $_g1[$_g];
				++$_g;
				{
					$_g2 = $f->t;
					$tmp1 = $_g2->index;
					switch($tmp1) {
					case 0:{
						$hasID = true;
					}break;
					case 2:case 4:{
						$hasID = true;
						if($dbName === "SQLite") {
							$tmp2 = _hx_substr(Std::string($f->t), 1, null);
							throw new HException("S" . _hx_string_or_null($tmp2) . " is not supported by " . _hx_string_or_null($dbName) . " : use SId instead");
						}
					}break;
					default:{}break;
					}
					unset($tmp1,$_g2);
				}
				$tmp3 = call_user_func_array($quote, array($f->name));
				$tmp4 = _hx_string_or_null($tmp3) . " ";
				$tmp5 = sys_db_TableCreate::getTypeSQL($f->t, $dbName);
				$tmp6 = _hx_string_or_null($tmp4) . _hx_string_or_null($tmp5);
				$tmp7 = null;
				if($f->isNull) {
					$tmp7 = "";
				} else {
					$tmp7 = " NOT NULL";
				}
				$decls->push(_hx_string_or_null($tmp6) . _hx_string_or_null($tmp7));
				unset($tmp7,$tmp6,$tmp5,$tmp4,$tmp3,$f);
			}
		}
		$tmp8 = null;
		if($dbName === "SQLite") {
			$tmp8 = !$hasID;
		} else {
			$tmp8 = true;
		}
		if($tmp8) {
			$tmp9 = Lambda::map($infos->key, $quote)->join(",");
			$decls->push("PRIMARY KEY (" . _hx_string_or_null($tmp9) . ")");
		}
		$tmp10 = $decls->join(",");
		$sql .= _hx_string_or_null($tmp10);
		$sql .= ")";
		if($engine !== null) {
			$sql .= "ENGINE=" . _hx_string_or_null($engine);
		}
		$cnx->request($sql);
	}
	static function exists($manager) {
		$cnx = $manager->getCnx();
		if($cnx === null) {
			throw new HException("SQL Connection not initialized on Manager");
		}
		try {
			$tmp = "SELECT * FROM `" . _hx_string_or_null($manager->dbInfos()->name);
			$cnx->request(_hx_string_or_null($tmp) . "` LIMIT 1");
			return true;
		}catch(Exception $__hx__e) {
			$_ex_ = ($__hx__e instanceof HException) && $__hx__e->getCode() == null ? $__hx__e->e : $__hx__e;
			$e = $_ex_;
			{
				return false;
			}
		}
	}
	function __toString() { return 'sys.db.TableCreate'; }
}
function sys_db_TableCreate_0(&$manager, $v) {
	{
		return $manager->quoteField($v);
	}
}