<?php

abstract class Db {
private static $username ="postgresAdmin";
private static $password ="postgres123";
private static $dsn ="pgsql:host=custom_maps_db;port=5432;dbname=maps_db;";
public static $affected_rows;


public static function connectToDatabase() {
    try {
        $pdo = new PDO(self::$dsn, self::$username, self::$password);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        return $pdo;
    } catch (PDOException $e) {
        echo "Connection failed: " . $e->getMessage();
        return null;
    }
}

public static function selectData($sql, $binding_values=[]){
    $pdo = self::connectToDatabase();
    $stmt = $pdo->prepare($sql);
    $stmt->execute($binding_values);
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
    return json_encode($result);
}


}
?>