class Place {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String description;
  final List<String> images;
  final double rating;
  final int reviewCount;
  final String category; // coffee, travel, etc.
  final double priceLevel; // 1-4
  final List<String> features; // wifi, outdoor, etc.
  final String? openingHours;
  final String? phone;
  final String? website;

  Place({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.images,
    required this.rating,
    required this.reviewCount,
    required this.category,
    required this.priceLevel,
    required this.features,
    this.openingHours,
    this.phone,
    this.website,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      description: json['description'],
      images: List<String>.from(json['images']),
      rating: json['rating'].toDouble(),
      reviewCount: json['reviewCount'],
      category: json['category'],
      priceLevel: json['priceLevel'].toDouble(),
      features: List<String>.from(json['features']),
      openingHours: json['openingHours'],
      phone: json['phone'],
      website: json['website'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'description': description,
      'images': images,
      'rating': rating,
      'reviewCount': reviewCount,
      'category': category,
      'priceLevel': priceLevel,
      'features': features,
      'openingHours': openingHours,
      'phone': phone,
      'website': website,
    };
  }
}
