const axios = require('axios');

const BASE_URL = 'http://localhost:3000/api';

// Test đăng ký
async function testRegister() {
  try {
    console.log('Testing user registration...');
    const response = await axios.post(`${BASE_URL}/auth/register`, {
      username: 'testuser',
      email: 'test@example.com',
      password: 'password123'
    });
    console.log('✅ Registration successful:', response.data);
    return response.data.token;
  } catch (error) {
    console.log('❌ Registration failed:', error.response?.data || error.message);
    return null;
  }
}

// Test đăng nhập
async function testLogin() {
  try {
    console.log('Testing user login...');
    const response = await axios.post(`${BASE_URL}/auth/login`, {
      email: 'test@example.com',
      password: 'password123'
    });
    console.log('✅ Login successful:', response.data);
    return response.data.token;
  } catch (error) {
    console.log('❌ Login failed:', error.response?.data || error.message);
    return null;
  }
}

// Test lấy thông tin user
async function testGetMe(token) {
  try {
    console.log('Testing get current user...');
    const response = await axios.get(`${BASE_URL}/auth/me`, {
      headers: { Authorization: `Bearer ${token}` }
    });
    console.log('✅ Get me successful:', response.data);
  } catch (error) {
    console.log('❌ Get me failed:', error.response?.data || error.message);
  }
}

// Test lấy danh sách places
async function testGetPlaces() {
  try {
    console.log('Testing get places...');
    const response = await axios.get(`${BASE_URL}/places`);
    console.log('✅ Get places successful:', response.data.length, 'places found');
  } catch (error) {
    console.log('❌ Get places failed:', error.response?.data || error.message);
  }
}

// Chạy tất cả tests
async function runTests() {
  console.log('🚀 Starting API tests...\n');

  // Test đăng ký
  const registerToken = await testRegister();
  console.log('');

  // Test đăng nhập
  const loginToken = await testLogin();
  console.log('');

  // Test get me với token từ đăng nhập
  if (loginToken) {
    await testGetMe(loginToken);
    console.log('');
  }

  // Test get places
  await testGetPlaces();
  console.log('');

  console.log('🏁 API tests completed!');
}

runTests();