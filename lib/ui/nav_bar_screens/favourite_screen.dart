import 'package:flutter/material.dart';
import 'package:my_store/provider/favourite_provider.dart';
import 'package:my_store/modals/prroduct_models.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Center(child: Text('Favourite Products')),
        backgroundColor: Colors.white,
      ),
      body: Consumer<FavouriteProvider>(
        builder: (context, favouriteProvider, child) {
          final List<Products> favoriteProducts =
              favouriteProvider.selectedItems;

          if (favoriteProducts.isEmpty) {
            return const Center(
              child: Text('No favorite products yet!'),
            );
          }

          return ListView.builder(
            itemCount: favoriteProducts.length,
            itemBuilder: (context, index) {
              final product = favoriteProducts[index];
              return ListTile(
                leading: Image.network(
                  product.thumbnail ?? 'default_image_url',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  product.title ?? 'No Title',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('\$${(product.price ?? 0).toStringAsFixed(2)}'),
                trailing: IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.red),
                  onPressed: () {
                    favouriteProvider.removeItem(product);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
