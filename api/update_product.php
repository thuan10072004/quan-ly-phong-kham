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

$id = $_POST['id'];
$name = $_POST['name'];
$price = $_POST['price'];
$category = $_POST['category'];

$sql = "UPDATE products SET name='$name', price='$price', category='$category' WHERE id=$id";

if ($conn->query($sql) === TRUE) {
    echo json_encode(["status" => "success", "message" => "Cập nhật thành công"]);
} else {
    echo json_encode(["status" => "error", "message" => "Lỗi: " . $conn->error]);
}

$conn->close();
?>