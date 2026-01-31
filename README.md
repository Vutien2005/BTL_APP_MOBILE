# Tài liệu Dự án BTL - Ứng dụng Khám phá Du lịch Cà phê

## Tổng quan

Dự án BTL bao gồm hai thành phần chính: **Backend** và **Ứng dụng Di động**. Backend được xây dựng bằng Node.js, Express và MongoDB, trong khi ứng dụng di động được phát triển bằng Flutter. Dự án này nhằm tạo ra một ứng dụng khám phá du lịch cà phê, nơi người dùng có thể tìm kiếm, đánh giá và chia sẻ các địa điểm cà phê thú vị.

## Backend (BTL Backend)

### Mô tả
Backend API phục vụ cho ứng dụng Coffee Travel Discovery App. Nó được thiết kế để xử lý các yêu cầu từ ứng dụng di động và quản lý dữ liệu liên quan đến du lịch cà phê, bao gồm thông tin người dùng, địa điểm và đánh giá.

### Công nghệ sử dụng
- **Node.js**: Môi trường chạy JavaScript phía server
- **Express.js**: Framework web cho Node.js
- **MongoDB**: Cơ sở dữ liệu NoSQL
- **Mongoose**: ODM cho MongoDB
- **JWT**: Xác thực người dùng
- **bcryptjs**: Mã hóa mật khẩu
- **CORS**: Cho phép cross-origin requests

### Cài đặt
1. **Cài đặt dependencies:**
   ```bash
   cd btl_backend
   npm install
   ```

2. **Thiết lập MongoDB:**
   - **Tùy chọn 1: MongoDB Atlas (Khuyến nghị cho phát triển)**
     - Tạo tài khoản tại [MongoDB Atlas](https://www.mongodb.com/atlas)
     - Tạo một cluster miễn phí
     - Lấy connection string và tạo file `.env` với biến `MONGODB_URI`
   - **Tùy chọn 2: MongoDB cục bộ**
     - Cài đặt MongoDB trên máy local
     - Sử dụng connection string mặc định: `mongodb://localhost:27017/btl_coffee_travel`

3. **Tạo file .env:**
   ```
   MONGODB_URI=your_mongodb_connection_string
   JWT_SECRET=your_jwt_secret_key
   PORT=3000
   ```

### Chạy ứng dụng
- **Chế độ phát triển:**
  ```bash
  npm run dev
  ```
- **Chế độ production:**
  ```bash
  npm start
  ```
- **Seed dữ liệu mẫu:**
  ```bash
  npm run seed
  ```
- **Test API:**
  ```bash
  npm run test-api
  ```

### API Endpoints
- **Authentication:** `/api/auth`
  - POST `/api/auth/register` - Đăng ký
  - POST `/api/auth/login` - Đăng nhập
  - POST `/api/auth/logout` - Đăng xuất
- **Places:** `/api/places`
  - GET `/api/places` - Lấy danh sách địa điểm
  - POST `/api/places` - Tạo địa điểm mới
  - GET `/api/places/:id` - Lấy chi tiết địa điểm
  - PUT `/api/places/:id` - Cập nhật địa điểm
  - DELETE `/api/places/:id` - Xóa địa điểm
- **Users:** `/api/users`
  - GET `/api/users/profile` - Lấy thông tin profile
  - PUT `/api/users/profile` - Cập nhật profile
- **Health Check:** `/api/health` - Kiểm tra trạng thái server

### Cấu trúc thư mục
```
btl_backend/
├── config/          # Cấu hình database
├── controllers/     # Logic xử lý API
│   ├── authController.js
│   ├── placesController.js
│   └── usersController.js
├── middleware/      # Middleware (auth, validation)
├── models/          # Mongoose models
│   ├── Place.js
│   └── User.js
├── routes/          # Định tuyến API
│   ├── auth.js
│   ├── places.js
│   └── users.js
├── server.js        # File chính của server
├── seed.js          # Script tạo dữ liệu mẫu
├── test-api.js      # Script test API
└── package.json
```

## Ứng dụng Di động (BTL Mobile)

### Mô tả
Ứng dụng di động là giao diện người dùng cho Coffee Travel Discovery App, được xây dựng bằng Flutter. Ứng dụng cho phép người dùng khám phá các địa điểm cà phê, xem bản đồ, đánh giá và lưu trữ địa điểm yêu thích.

### Công nghệ sử dụng
- **Flutter**: Framework phát triển ứng dụng đa nền tảng
- **Dart**: Ngôn ngữ lập trình
- **Provider**: Quản lý trạng thái
- **Go Router**: Điều hướng
- **Google Maps Flutter**: Tích hợp bản đồ
- **Geolocator**: Lấy vị trí GPS
- **Cached Network Image**: Cache hình ảnh
- **Shared Preferences**: Lưu trữ cục bộ

### Cài đặt
1. **Cài đặt Flutter:**
   - Tải và cài đặt Flutter SDK từ [flutter.dev](https://flutter.dev)
   - Thêm Flutter vào PATH

2. **Cài đặt dependencies:**
   ```bash
   cd btl_mobile
   flutter pub get
   ```

3. **Thiết lập Android/iOS:**
   - **Android:** Cài đặt Android Studio và SDK
   - **iOS:** Cài đặt Xcode (chỉ trên macOS)

### Chạy ứng dụng
- **Chạy trên thiết bị ảo:**
  ```bash
  flutter run
  ```
- **Chạy trên thiết bị thật:**
  - Kết nối thiết bị và bật USB debugging
  - Chạy `flutter run`

- **Build release:**
  ```bash
  flutter build apk  # Android
  flutter build ios  # iOS
  ```

### Cấu trúc thư mục
```
btl_mobile/
├── lib/
│   ├── main.dart           # File chính
│   ├── models/             # Data models
│   │   ├── place.dart
│   │   └── user.dart
│   ├── providers/          # State management
│   │   ├── auth_provider.dart
│   │   └── places_provider.dart
│   ├── repositories/       # Data repositories
│   ├── screens/            # UI screens
│   │   ├── onboarding_screen.dart
│   │   ├── login_screen.dart
│   │   ├── signup_screen.dart
│   │   ├── home_screen.dart
│   │   ├── search_screen.dart
│   │   ├── map_screen.dart
│   │   ├── place_detail_screen.dart
│   │   ├── favorites_screen.dart
│   │   └── profile_screen.dart
│   └── widgets/            # Reusable widgets
├── android/                # Android specific files
├── ios/                    # iOS specific files
├── web/                    # Web specific files
├── test/                   # Unit tests
└── pubspec.yaml
```

### Tính năng chính
- **Onboarding:** Giới thiệu ứng dụng
- **Authentication:** Đăng nhập/đăng ký
- **Home:** Trang chủ với danh sách địa điểm
- **Search:** Tìm kiếm địa điểm
- **Map:** Xem bản đồ với vị trí địa điểm
- **Place Details:** Chi tiết địa điểm và đánh giá
- **Favorites:** Danh sách địa điểm yêu thích
- **Profile:** Thông tin cá nhân

## Cách sử dụng

1. **Khởi động Backend:**
   - Thực hiện các bước cài đặt backend
   - Chạy `npm run dev` để khởi động server

2. **Khởi động Mobile App:**
   - Thực hiện các bước cài đặt mobile
   - Chạy `flutter run` để khởi động ứng dụng

3. **Kết nối:**
   - Đảm bảo backend đang chạy trên port 3000
   - Ứng dụng mobile sẽ kết nối tới API backend

## Đóng góp

1. Fork dự án
2. Tạo branch mới (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Tạo Pull Request

## Giấy phép

Dự án này được phân phối dưới giấy phép ISC.

## Liên hệ

Nếu có câu hỏi hoặc góp ý, vui lòng tạo issue trên GitHub hoặc liên hệ với nhóm phát triển.

---

*Tài liệu này được tạo tự động dựa trên cấu trúc dự án. Vui lòng tham khảo các file README riêng trong từng thư mục con để có thông tin chi tiết hơn.*
