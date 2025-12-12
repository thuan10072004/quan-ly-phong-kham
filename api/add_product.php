<?php
// --- HEADER CORS (Bắt buộc cho Web) ---
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    http_response_code(200);
    exit();
}
// -------------------------------------

include 'db_connect.php';

$name = $_POST['name'];
$price = $_POST['price'];
$category = $_POST['category'];

$sql = "INSERT INTO products (name, price, category) VALUES ('$name', '$price', '$category')";

if ($conn->query($sql) === TRUE) {
    echo json_encode(["status" => "success", "message" => "Thêm thành công"]);
} else {
    echo json_encode(["status" => "error", "message" => "Lỗi: " . $conn->error]);
}

$conn->close();
?>