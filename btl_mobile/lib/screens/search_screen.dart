import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/places_provider.dart';
import '../widgets/place_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  List<String> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    if (query.isEmpty) {
      setState(() => _searchResults = []);
      return;
    }

    final placesProvider = context.read<PlacesProvider>();
    final results = placesProvider.searchPlaces(query);
    setState(() => _searchResults = results.map((p) => p.id).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tìm kiếm'),
        backgroundColor: Colors.brown,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Tìm quán cà phê, điểm du lịch...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
            ),
          ),

          // Filters
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildFilterChip('Tất cả'),
                _buildFilterChip('Cà phê'),
                _buildFilterChip('Du lịch'),
                _buildFilterChip('Wifi'),
                _buildFilterChip('Outdoor'),
                _buildFilterChip('View đẹp'),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Results
          Expanded(
            child: _searchController.text.isEmpty
                ? const Center(child: Text('Nhập từ khóa để tìm kiếm'))
                : Consumer<PlacesProvider>(
                    builder: (context, placesProvider, child) {
                      final results = placesProvider.places
                          .where((place) => _searchResults.contains(place.id))
                          .toList();

                      if (results.isEmpty) {
                        return const Center(
                          child: Text('Không tìm thấy kết quả'),
                        );
                      }

                      return ListView.builder(
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          final place = results[index];
                          return PlaceCard(
                            place: place,
                            onTap: () => context.go('/place/${place.id}'),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        onSelected: (selected) {
          // TODO: Implement filter logic
        },
        backgroundColor: Colors.grey.shade100,
        selectedColor: Colors.brown.shade100,
      ),
    );
  }
}
