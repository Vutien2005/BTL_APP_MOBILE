const Place = require('../models/Place');

// @desc    Get all places
// @route   GET /api/places
// @access  Public
const getPlaces = async (req, res) => {
  try {
    const { category, search, limit = 10, page = 1 } = req.query;

    let query = {};

    // Filter by category
    if (category) {
      query.category = category;
    }

    // Search by name or address
    if (search) {
      query.$or = [
        { name: { $regex: search, $options: 'i' } },
        { address: { $regex: search, $options: 'i' } }
      ];
    }

    const places = await Place.find(query)
      .limit(limit * 1)
      .skip((page - 1) * limit)
      .sort({ createdAt: -1 });

    const total = await Place.countDocuments(query);

    res.json({
      places,
      totalPages: Math.ceil(total / limit),
      currentPage: page,
      total
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Server error' });
  }
};

// @desc    Get single place
// @route   GET /api/places/:id
// @access  Public
const getPlace = async (req, res) => {
  try {
    const place = await Place.findById(req.params.id).populate('reviews.user', 'name avatarUrl');

    if (!place) {
      return res.status(404).json({ error: 'Place not found' });
    }

    res.json(place);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Server error' });
  }
};

// @desc    Create new place
// @route   POST /api/places
// @access  Private (Admin only)
const createPlace = async (req, res) => {
  try {
    const place = new Place(req.body);
    await place.save();
    res.status(201).json(place);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Server error' });
  }
};

// @desc    Update place
// @route   PUT /api/places/:id
// @access  Private (Admin only)
const updatePlace = async (req, res) => {
  try {
    const place = await Place.findByIdAndUpdate(req.params.id, req.body, {
      new: true,
      runValidators: true
    });

    if (!place) {
      return res.status(404).json({ error: 'Place not found' });
    }

    res.json(place);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Server error' });
  }
};

// @desc    Delete place
// @route   DELETE /api/places/:id
// @access  Private (Admin only)
const deletePlace = async (req, res) => {
  try {
    const place = await Place.findByIdAndDelete(req.params.id);

    if (!place) {
      return res.status(404).json({ error: 'Place not found' });
    }

    res.json({ message: 'Place removed' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Server error' });
  }
};

// @desc    Add review to place
// @route   POST /api/places/:id/reviews
// @access  Private
const addReview = async (req, res) => {
  try {
    const { rating, comment } = req.body;

    const place = await Place.findById(req.params.id);

    if (!place) {
      return res.status(404).json({ error: 'Place not found' });
    }

    // Check if user already reviewed
    const existingReview = place.reviews.find(
      review => review.user.toString() === req.user._id.toString()
    );

    if (existingReview) {
      return res.status(400).json({ error: 'You have already reviewed this place' });
    }

    // Add review
    place.reviews.push({
      user: req.user._id,
      rating,
      comment
    });

    // Recalculate average rating
    place.calculateAverageRating();
    await place.save();

    res.status(201).json(place);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Server error' });
  }
};

// @desc    Get places near location
// @route   GET /api/places/nearby
// @access  Public
const getNearbyPlaces = async (req, res) => {
  try {
    const { lat, lng, radius = 5000 } = req.query; // radius in meters

    if (!lat || !lng) {
      return res.status(400).json({ error: 'Latitude and longitude are required' });
    }

    const places = await Place.find({
      location: {
        $near: {
          $geometry: {
            type: 'Point',
            coordinates: [parseFloat(lng), parseFloat(lat)]
          },
          $maxDistance: parseInt(radius)
        }
      }
    });

    res.json(places);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Server error' });
  }
};

module.exports = {
  getPlaces,
  getPlace,
  createPlace,
  updatePlace,
  deletePlace,
  addReview,
  getNearbyPlaces
};