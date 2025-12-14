
# Báo cáo Bài tập lớn: Ứng dụng Quản lý Phòng Khám

## 1. Thông tin sinh viên
- **Họ và tên**: Bùi Ngọc Thuấn
- **MSSV**: 2221050358
- **Lớp**: DCCTCLC67B

## 2. Giới thiệu dự án
Ứng dụng **Clinic Management** là giải pháp di động giúp quản lý danh mục thuốc và vật tư y tế. Ứng dụng cho phép người dùng (nhân viên y tế/quản lý) thực hiện các thao tác thêm, xem, sửa, xóa (CRUD) thông tin thuốc, đồng thời hỗ trợ tìm kiếm và sắp xếp dữ liệu theo thời gian thực.

Dự án được xây dựng theo kiến trúc **MVVM** (Model - View - ViewModel), kết nối với Backend **PHP & MySQL** và đảm bảo quy trình **CI/CD** tự động thông qua GitHub Actions.

## 3. Công nghệ và Thư viện sử dụng
- **Ngôn ngữ & Framework**: Flutter (Dart).
- **Backend**: PHP (API thuần), MySQL (Cơ sở dữ liệu XAMPP).
- **Quản lý trạng thái (State Management)**: `provider`.
- **Kết nối mạng**: `http` (Gọi RESTful API).
- **Cấu trúc dữ liệu**: JSON.
- **Kiểm thử**: `flutter_test`, `mockito`.
- **CI/CD**: GitHub Actions.
- **Giao diện**: Material Design 3, `google_fonts`.

## 4. Các chức năng chính 
### a. Chức năng CRUD 
- **Create (Thêm)**: Thêm mới thuốc với validation kỹ càng (bắt buộc nhập tên, giá phải là số dương).
- **Read (Xem)**: Hiển thị danh sách thuốc từ Server MySQL, có hiệu ứng loading.
- **Update (Sửa)**: Cập nhật thông tin thuốc, tự động làm mới danh sách sau khi sửa.
- **Delete (Xóa)**: Xóa thuốc khỏi cơ sở dữ liệu.

### b. Chức năng Nâng cao
- **Tìm kiếm (Search)**: Tìm kiếm thuốc theo tên ngay lập tức (Real-time filtering) tại phía Client.
- **Sắp xếp (Sort)**: Sắp xếp danh sách thuốc theo Giá tiền (Tăng dần / Giảm dần).
- **Tự động nhận diện môi trường**: Code tự động chuyển đổi IP API (`localhost` khi chạy Web, `10.0.2.2` khi chạy Android Emulator).

### c. Kiểm thử & CI/CD
- **Unit Test**: Kiểm thử Logic Model, chuyển đổi dữ liệu JSON/Double.
- **Widget Test**: Kiểm thử hiển thị giao diện người dùng (nút bấm, tiêu đề).
- **GitHub Actions**: Tự động chạy test và build mỗi khi có code mới được đẩy lên (Push).

## 5. Hướng dẫn cài đặt và Chạy ứng dụng


### Bước 1: Cấu hình Backend (XAMPP)
1. Bật **Apache** và **MySQL** trong XAMPP.
2. Vào `phpMyAdmin`, tạo database tên: `flutter_clinic_final`.
3. Chạy lệnh SQL sau để tạo bảng và dữ liệu mẫu:
   ```sql
   CREATE TABLE products (
       id INT AUTO_INCREMENT PRIMARY KEY,
       name VARCHAR(255) NOT NULL,
       price DOUBLE NOT NULL,
       category VARCHAR(100) NOT NULL
   );
   INSERT INTO products (name, price, category) VALUES ('Panadol', 15000, 'Giảm đau');
````

4.  Copy thư mục `api` (có trong source code) vào thư mục `htdocs` của XAMPP (`C:\xampp\htdocs\api`).

### Bước 2: Chạy ứng dụng Flutter

1.  Tải mã nguồn:
    ```bash
    git clone <link-repo-cua-ban>
    ```
2.  Cài đặt thư viện:
    ```bash
    flutter pub get
    ```
3.  Chạy ứng dụng (Hỗ trợ cả Web và Android):
    ```bash
    flutter run
    ```

### Bước 3: Chạy Kiểm thử tự động

Để kiểm tra Unit Test và Widget Test:

```bash
flutter test
```

## 6\. Video Demo

*Link video demo các chức năng và quá trình kiểm thử sẽ được cập nhật tại đây:*

  - **Video 1 https://youtu.be/0n9fiQJ4Wzw
  - **Video 2 https://youtu.be/vDI4DmyL5pQ

## 7\. Kết quả CI/CD (GitHub Actions)

  - Trạng thái Workflow: **Success** 
  - File cấu hình: `.github/workflows/ci.yml`
  - Đã vượt qua tất cả các bài test trên môi trường ảo Ubuntu.

## 8\. Tự đánh giá điểm: 9/10

Dựa trên tiêu chí đánh giá, nhóm tự đánh giá đạt điểm tối đa vì:

  - [x] Build thành công, không lỗi.
  - [x] CRUD hoàn chỉnh với Database MySQL.
  - [x] Có tính năng tìm kiếm, sắp xếp (UI/UX mượt mà).
  - [x] Xử lý lỗi API và Validation form tốt.
  - [x] Viết đầy đủ Unit Test và Widget Test.
  - [x] GitHub Actions hoạt động ổn định (Success).

-----

*Cảm ơn Giảng viên đã xem xét bài tập lớn của em\!*

```
```