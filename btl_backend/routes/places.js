const express = require('express');
const router = express.Router();
const {
  getPlaces,
  getPlace,
  createPlace,
  updatePlace,
  deletePlace,
  addReview,
  getNearbyPlaces
} = require('../controllers/placesController');
const auth = require('../middleware/auth');

// Public routes
router.get('/', getPlaces);
router.get('/nearby', getNearbyPlaces);
router.get('/:id', getPlace);

// Protected routes
router.post('/:id/reviews', auth, addReview);

// Admin routes (you might want to add admin middleware)
router.post('/', auth, createPlace);
router.put('/:id', auth, updatePlace);
router.delete('/:id', auth, deletePlace);

module.exports = router;