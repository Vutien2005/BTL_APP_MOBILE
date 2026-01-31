const express = require('express');
const router = express.Router();
const {
  getUserProfile,
  updateUserProfile,
  addToFavorites,
  removeFromFavorites,
  getUserFavorites
} = require('../controllers/usersController');
const auth = require('../middleware/auth');

// All routes require authentication
router.use(auth);

router.get('/profile', getUserProfile);
router.put('/profile', updateUserProfile);
router.get('/favorites', getUserFavorites);
router.post('/favorites/:placeId', addToFavorites);
router.delete('/favorites/:placeId', removeFromFavorites);

module.exports = router;