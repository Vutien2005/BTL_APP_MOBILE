# BTL Backend - Coffee Travel Discovery API

Backend API cho ứng dụng Coffee Travel Discovery App, được xây dựng bằng Node.js, Express và MongoDB.

## 🚀 Quick Start

Xem [SETUP_GUIDE.md](SETUP_GUIDE.md) để có hướng dẫn chi tiết về cách thiết lập MongoDB Atlas và test API.

## Cài đặt

1. **Cài đặt dependencies:**
   ```bash
   npm install
   ```

2. **Thiết lập MongoDB:**

   **Tùy chọn 1: MongoDB Atlas (Khuyến nghị cho development)**
   - Tạo tài khoản tại [MongoDB Atlas](https://www.mongodb.com/atlas)
   - Tạo một cluster miễn phí
   - Tạo database user và whitelist IP
   - Lấy connection string và cập nhật vào `.env`:
     ```
     MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/btl_coffee_travel?retryWrites=true&w=majority
     ```

   **Tùy chọn 2: MongoDB Local**
   - Tải và cài đặt MongoDB từ [mongodb.com](https://www.mongodb.com/try/download/community)
   - Khởi động MongoDB service
   - Connection string mặc định: `mongodb://localhost:27017/btl_coffee_travel`

3. **Cấu hình environment variables:**
   - Sao chép file `.env.example` thành `.env`
   - Cập nhật các biến môi trường trong `.env`

4. **Khởi động server:**
   ```bash
   # Development mode
   npm run dev

   # Production mode
   npm start
   ```

5. **Seed database với dữ liệu mẫu (tùy chọn):**
   ```bash
   npm run seed
   ```

6. **Test API endpoints:**
   ```bash
   npm run test-api
   ```

Server sẽ chạy trên `http://localhost:3000`

## API Endpoints

### Authentication
- `POST /api/auth/register` - Đăng ký tài khoản mới
- `POST /api/auth/login` - Đăng nhập
- `GET /api/auth/me` - Lấy thông tin user hiện tại

### Places
- `GET /api/places` - Lấy danh sách địa điểm
- `GET /api/places/:id` - Lấy chi tiết địa điểm
- `GET /api/places/nearby?lat=:lat&lng=:lng&radius=:radius` - Lấy địa điểm gần vị trí
- `POST /api/places` - Tạo địa điểm mới (Admin)
- `PUT /api/places/:id` - Cập nhật địa điểm (Admin)
- `DELETE /api/places/:id` - Xóa địa điểm (Admin)
- `POST /api/places/:id/reviews` - Thêm đánh giá

### Users
- `GET /api/users/profile` - Lấy thông tin profile
- `PUT /api/users/profile` - Cập nhật profile
- `GET /api/users/favorites` - Lấy danh sách yêu thích
- `POST /api/users/favorites/:placeId` - Thêm vào yêu thích
- `DELETE /api/users/favorites/:placeId` - Xóa khỏi yêu thích

## Cấu trúc Database

### User
```javascript
{
  name: String,
  email: String,
  password: String, // hashed
  phone: String,
  avatarUrl: String,
  favorites: [ObjectId], // references to Place
  createdAt: Date,
  updatedAt: Date
}
```

### Place
```javascript
{
  name: String,
  address: String,
  latitude: Number,
  longitude: Number,
  description: String,
  images: [String],
  rating: Number,
  reviewCount: Number,
  category: String, // 'coffee', 'travel', 'restaurant', 'attraction'
  priceLevel: Number, // 1-4
  features: [String], // ['wifi', 'outdoor', 'parking', etc.]
  openingHours: String,
  phone: String,
  website: String,
  reviews: [{
    user: ObjectId, // reference to User
    rating: Number,
    comment: String,
    createdAt: Date
  }],
  createdAt: Date,
  updatedAt: Date
}
```

## Authentication

API sử dụng JWT (JSON Web Tokens) để xác thực. Khi đăng nhập thành công, server sẽ trả về token. Client cần gửi token trong header `Authorization: Bearer <token>` cho các API protected.

## Development

### Scripts
- `npm start` - Khởi động server
- `npm run dev` - Khởi động server với nodemon (auto restart)
- `npm test` - Chạy tests

### Environment Variables
```env
PORT=3000
MONGODB_URI=mongodb://localhost:27017/btl_coffee_travel
JWT_SECRET=your_jwt_secret_key_here
NODE_ENV=development
```

## Kết nối với Flutter App

Backend này được thiết kế để phục vụ cho ứng dụng Flutter `btl_mobile`. Các API endpoints tương ứng với các chức năng trong app:

- Authentication APIs phục vụ login/signup
- Places APIs cung cấp dữ liệu địa điểm
- Users APIs quản lý profile và favorites

## Contributing

1. Fork repository
2. Tạo feature branch
3. Commit changes
4. Push to branch
5. Tạo Pull Request