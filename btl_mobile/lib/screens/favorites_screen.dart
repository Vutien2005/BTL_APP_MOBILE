import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/places_provider.dart';
import '../widgets/place_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yêu thích'),
        backgroundColor: Colors.brown,
      ),
      body: Consumer<PlacesProvider>(
        builder: (context, placesProvider, child) {
          final favorites = placesProvider.favorites;

          if (favorites.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Chưa có địa điểm yêu thích',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Hãy khám phá và lưu những địa điểm bạn thích',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final place = favorites[index];
              return PlaceCard(
                place: place,
                onTap: () => context.go('/place/${place.id}'),
              );
            },
          );
        },
      ),
    );
  }
}
