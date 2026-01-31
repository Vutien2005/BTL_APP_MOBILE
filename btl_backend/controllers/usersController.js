const User = require('../models/User');

// @desc    Get user profile
// @route   GET /api/users/profile
// @access  Private
const getUserProfile = async (req, res) => {
  try {
    const user = await User.findById(req.user._id)
      .select('-password')
      .populate('favorites', 'name address images rating');

    res.json(user);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Server error' });
  }
};

// @desc    Update user profile
// @route   PUT /api/users/profile
// @access  Private
const updateUserProfile = async (req, res) => {
  try {
    const { name, phone, avatarUrl } = req.body;

    const user = await User.findByIdAndUpdate(
      req.user._id,
      { name, phone, avatarUrl },
      { new: true, runValidators: true }
    ).select('-password');

    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }

    res.json(user);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Server error' });
  }
};

// @desc    Add place to favorites
// @route   POST /api/users/favorites/:placeId
// @access  Private
const addToFavorites = async (req, res) => {
  try {
    const user = await User.findById(req.user._id);

    if (!user.favorites.includes(req.params.placeId)) {
      user.favorites.push(req.params.placeId);
      await user.save();
    }

    res.json({ message: 'Added to favorites' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Server error' });
  }
};

// @desc    Remove place from favorites
// @route   DELETE /api/users/favorites/:placeId
// @access  Private
const removeFromFavorites = async (req, res) => {
  try {
    const user = await User.findById(req.user._id);

    user.favorites = user.favorites.filter(
      fav => fav.toString() !== req.params.placeId
    );

    await user.save();

    res.json({ message: 'Removed from favorites' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Server error' });
  }
};

// @desc    Get user favorites
// @route   GET /api/users/favorites
// @access  Private
const getUserFavorites = async (req, res) => {
  try {
    const user = await User.findById(req.user._id).populate('favorites');

    res.json(user.favorites);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Server error' });
  }
};

module.exports = {
  getUserProfile,
  updateUserProfile,
  addToFavorites,
  removeFromFavorites,
  getUserFavorites
};