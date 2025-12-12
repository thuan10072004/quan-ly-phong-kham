<?php
$servername = "localhost";
$username = "root";
$password = "";

// --- SỬA DÒNG NÀY ---
$dbname = "flutter_clinic_final"; // Đổi thành tên mới bạn vừa tạo ở trên
// --------------------

$conn = new mysqli($servername, $username, $password, $dbname);
$conn->set_charset("utf8");

if ($conn->connect_error) {
    die("Kết nối thất bại: " . $conn->connect_error);
}
?>