# Hướng dẫn Setup MongoDB Atlas và Test API

## Bước 1: Tạo tài khoản MongoDB Atlas

1. Truy cập [https://www.mongodb.com/atlas](https://www.mongodb.com/atlas)
2. Đăng ký tài khoản miễn phí
3. Chọn "Create a New Cluster" (Miễn phí)

## Bước 2: Cấu hình Database

1. **Tạo Database User:**
   - Vào "Database Access" > "Add New Database User"
   - Username: `btluser`
   - Password: `btlpassword123` (hoặc password khác)
   - Built-in Role: `Read and write to any database`

2. **Whitelist IP Address:**
   - Vào "Network Access" > "Add IP Address"
   - Chọn "Allow Access from Anywhere" (hoặc thêm IP của bạn)

3. **Lấy Connection String:**
   - Vào "Clusters" > "Connect"
   - Chọn "Connect your application"
   - Copy connection string, ví dụ:
     ```
     mongodb+srv://btluser:btlpassword123@cluster0.xxxxx.mongodb.net/?retryWrites=true&w=majority
     ```

## Bước 3: Cập nhật file .env

Trong file `D:\HocTap\App\btl_backend\.env`, thay thế `MONGODB_URI`:

```env
MONGODB_URI=mongodb+srv://btluser:btlpassword123@cluster0.xxxxx.mongodb.net/btl_coffee_travel?retryWrites=true&w=majority
```

## Bước 4: Test Backend

1. **Khởi động server:**
   ```bash
   cd D:\HocTap\App\btl_backend
   npm run dev
   ```

2. **Seed database:**
   ```bash
   npm run seed
   ```

3. **Test API:**
   ```bash
   npm run test-api
   ```

## Kết quả mong đợi

Sau khi chạy `npm run test-api`, bạn sẽ thấy:

```
🚀 Starting API tests...

Testing user registration...
✅ Registration successful: { user: {...}, token: "..." }

Testing user login...
✅ Login successful: { user: {...}, token: "..." }

Testing get current user...
✅ Get me successful: { user: {...} }

Testing get places...
✅ Get places successful: X places found

🏁 API tests completed!
```

## Xử lý sự cố

- **Lỗi kết nối MongoDB:** Kiểm tra connection string trong .env
- **Lỗi Authentication failed:** Kiểm tra username/password trong connection string
- **Lỗi Network access:** Đảm bảo IP được whitelist trong Atlas
- **Lỗi JWT:** Kiểm tra JWT_SECRET trong .env

## API Endpoints chính

- **POST /api/auth/register** - Đăng ký
- **POST /api/auth/login** - Đăng nhập
- **GET /api/auth/me** - Lấy thông tin user
- **GET /api/places** - Lấy danh sách địa điểm
- **POST /api/places/:id/reviews** - Thêm đánh giá
- **POST /api/users/favorites/:placeId** - Thêm yêu thích