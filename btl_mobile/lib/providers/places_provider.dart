import 'package:flutter/material.dart';
import '../models/place.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _places = [];
  final List<Place> _favorites = [];
  List<Place> _nearbyPlaces = [];

  List<Place> get places => _places;
  List<Place> get favorites => _favorites;
  List<Place> get nearbyPlaces => _nearbyPlaces;

  // Mock data for now
  void loadPlaces() {
    _places = [
      Place(
        id: '1',
        name: 'Coffee House A',
        address: '123 Main St, City',
        latitude: 37.7749,
        longitude: -122.4194,
        description: 'A cozy coffee shop with great views.',
        images: ['https://example.com/image1.jpg'],
        rating: 4.5,
        reviewCount: 120,
        category: 'coffee',
        priceLevel: 2.0,
        features: ['wifi', 'outdoor'],
        openingHours: '8:00 AM - 8:00 PM',
        phone: '+1234567890',
      ),
      // Add more places
    ];
    notifyListeners();
  }

  void loadNearbyPlaces(double lat, double lng) {
    // TODO: Load nearby places based on location
    _nearbyPlaces = _places.where((place) {
      // Simple distance check
      return true; // For now
    }).toList();
    notifyListeners();
  }

  void toggleFavorite(Place place) {
    if (_favorites.contains(place)) {
      _favorites.remove(place);
    } else {
      _favorites.add(place);
    }
    notifyListeners();
  }

  bool isFavorite(Place place) {
    return _favorites.contains(place);
  }

  List<Place> searchPlaces(String query) {
    return _places
        .where(
          (place) =>
              place.name.toLowerCase().contains(query.toLowerCase()) ||
              place.address.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }
}
