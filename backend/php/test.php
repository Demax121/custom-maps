<?php
header('Content-Type: application/json');

try {
    $pdo = new PDO(
        "pgsql:host=dev_postgres;dbname=basePostgresDB",
        getenv('POSTGRES_USER'),
        getenv('POSTGRES_PASSWORD')
    );
    
    $data = $pdo->query('SELECT * FROM TEST')->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode(['success' => true, 'data' => $data]);
    
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}