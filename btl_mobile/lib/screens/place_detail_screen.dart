import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../providers/places_provider.dart';
import '../models/place.dart';

class PlaceDetailScreen extends StatelessWidget {
  final String placeId;

  const PlaceDetailScreen({super.key, required this.placeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PlacesProvider>(
        builder: (context, placesProvider, child) {
          final place = placesProvider.places.firstWhere(
            (p) => p.id == placeId,
            orElse: () => Place(
              id: '',
              name: 'Not found',
              address: '',
              latitude: 0,
              longitude: 0,
              description: '',
              images: [],
              rating: 0,
              reviewCount: 0,
              category: '',
              priceLevel: 0,
              features: [],
            ),
          );

          if (place.id.isEmpty) {
            return const Center(child: Text('Place not found'));
          }

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 250,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: place.images.isNotEmpty
                      ? Image.network(place.images.first, fit: BoxFit.cover)
                      : Container(
                          color: Colors.grey.shade200,
                          child: const Icon(
                            Icons.image_not_supported,
                            size: 50,
                            color: Colors.grey,
                          ),
                        ),
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      placesProvider.isFavorite(place)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: placesProvider.isFavorite(place)
                          ? Colors.red
                          : Colors.white,
                    ),
                    onPressed: () => placesProvider.toggleFavorite(place),
                  ),
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {
                      // TODO: Share functionality
                    },
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name and rating
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              place.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          RatingBar.builder(
                            initialRating: place.rating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 20,
                            ignoreGestures: true,
                            itemBuilder: (context, _) =>
                                const Icon(Icons.star, color: Colors.amber),
                            onRatingUpdate: (rating) {},
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${place.rating} (${place.reviewCount})',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // Address
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 20,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              place.address,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Action buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // TODO: Get directions
                              },
                              icon: const Icon(Icons.directions),
                              label: const Text('Chỉ đường'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                // TODO: Call
                              },
                              icon: const Icon(Icons.call),
                              label: const Text('Gọi'),
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Description
                      const Text(
                        'Mô tả',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        place.description,
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),

                      const SizedBox(height: 24),

                      // Features
                      if (place.features.isNotEmpty) ...[
                        const Text(
                          'Tính năng',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: place.features.map((feature) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.brown.shade50,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                feature,
                                style: TextStyle(color: Colors.brown.shade700),
                              ),
                            );
                          }).toList(),
                        ),
                      ],

                      const SizedBox(height: 24),

                      // Opening hours
                      if (place.openingHours != null) ...[
                        const Text(
                          'Giờ mở cửa',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          place.openingHours!,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],

                      const SizedBox(height: 24),

                      // Price level
                      Row(
                        children: [
                          const Text(
                            'Mức giá: ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\$' * place.priceLevel.toInt(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Reviews section
                      const Text(
                        'Đánh giá',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // TODO: Add reviews list
                      const Text('Chưa có đánh giá nào'),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
