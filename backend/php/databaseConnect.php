<?php

abstract class Db {
    private static $username;
    private static $password;
    private static $dsn;
    public static $affected_rows;

    private static function init() {
        if (self::$dsn === null) {
            $db_host = getenv('POSTGRES_HOST');
            $db_name = getenv('POSTGRES_DB');
            $db_port = '5432';
            
            self::$username = getenv('POSTGRES_USER');
            self::$password = getenv('POSTGRES_PASSWORD');
            
            if (!$db_host || !$db_name || !self::$username || !self::$password) {
                throw new Exception("Database configuration missing from environment variables.");
            }

            self::$dsn = "pgsql:host=$db_host;port=$db_port;dbname=$db_name;";
        }
    }

    public static function connectToDatabase() {
        self::init();
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