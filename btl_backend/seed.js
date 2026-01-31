const mongoose = require('mongoose');
const Place = require('./models/Place');
require('dotenv').config();

const samplePlaces = [
  {
    name: 'The Coffee House - Vincom Center',
    address: 'Tầng 5, Vincom Center, 72 Lê Thánh Tôn, P. Bến Nghé, Quận 1, TP.HCM',
    latitude: 10.7745,
    longitude: 106.7019,
    description: 'Chuỗi cà phê nổi tiếng với không gian hiện đại, phục vụ các loại cà phê chất lượng cao và các món ăn nhẹ.',
    images: ['https://example.com/coffee1.jpg'],
    category: 'coffee',
    priceLevel: 3,
    features: ['wifi', 'outdoor'],
    openingHours: '7:00 AM - 10:00 PM',
    phone: '+84 28 3822 8888',
    website: 'https://thecoffeehouse.com'
  },
  {
    name: 'Phố đi bộ Nguyễn Huệ',
    address: 'Đường Nguyễn Huệ, Quận 1, TP.HCM',
    latitude: 10.7742,
    longitude: 106.7033,
    description: 'Phố đi bộ nổi tiếng của TP.HCM với nhiều hoạt động giải trí, mua sắm và ẩm thực đường phố.',
    images: ['https://example.com/street1.jpg'],
    category: 'travel',
    priceLevel: 2,
    features: ['outdoor', 'parking'],
    openingHours: '5:00 PM - 11:00 PM',
    phone: '',
    website: ''
  },
  {
    name: 'Cà phê Trung Nguyên Legend',
    address: '26 Lý Tự Trọng, Quận 1, TP.HCM',
    latitude: 10.7769,
    longitude: 106.7036,
    description: 'Cà phê truyền thống Việt Nam với hương vị đặc trưng, không gian ấm cúng.',
    images: ['https://example.com/coffee2.jpg'],
    category: 'coffee',
    priceLevel: 2,
    features: ['wifi'],
    openingHours: '6:00 AM - 10:00 PM',
    phone: '+84 28 3829 6666',
    website: 'https://trungnguyenlegend.com'
  },
  {
    name: 'Dinh Độc Lập',
    address: '135 Nam Kỳ Khởi Nghĩa, Quận 1, TP.HCM',
    latitude: 10.7771,
    longitude: 106.6953,
    description: 'Công trình kiến trúc lịch sử quan trọng, nơi diễn ra nhiều sự kiện lịch sử của Việt Nam.',
    images: ['https://example.com/palace1.jpg'],
    category: 'travel',
    priceLevel: 2,
    features: ['parking', 'wheelchair_accessible'],
    openingHours: '7:30 AM - 11:00 AM, 1:00 PM - 4:00 PM',
    phone: '+84 28 3829 4117',
    website: 'https://dinhdoclap.gov.vn'
  },
  {
    name: 'Starbucks - Crescent Mall',
    address: 'Tầng 2, Crescent Mall, 101 Tôn Dật Tiên, Quận 7, TP.HCM',
    latitude: 10.7298,
    longitude: 106.7203,
    description: 'Chuỗi cà phê quốc tế với không gian hiện đại, phục vụ các loại đồ uống và bánh ngọt.',
    images: ['https://example.com/coffee3.jpg'],
    category: 'coffee',
    priceLevel: 3,
    features: ['wifi', 'outdoor', 'parking'],
    openingHours: '7:00 AM - 10:00 PM',
    phone: '+84 28 5413 8888',
    website: 'https://starbucks.vn'
  }
];

const seedDatabase = async () => {
  try {
    await mongoose.connect(process.env.MONGODB_URI || 'mongodb://localhost:27017/btl_coffee_travel');

    // Clear existing data
    await Place.deleteMany({});

    // Insert sample data
    await Place.insertMany(samplePlaces);

    console.log('Database seeded successfully!');
    process.exit(0);
  } catch (error) {
    console.error('Error seeding database:', error);
    process.exit(1);
  }
};

seedDatabase();