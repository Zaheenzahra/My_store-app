import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_store/modals/single_product_model.dart';
import 'package:http/http.dart' as http;
import 'package:my_store/widgets/product_by_category.dart';

class ProductbyCategoryScreen extends StatefulWidget {
  const ProductbyCategoryScreen({super.key});

  @override
  State<ProductbyCategoryScreen> createState() =>
      _ProductbyCategoryScreenState();
}

class _ProductbyCategoryScreenState extends State<ProductbyCategoryScreen> {
  TextEditingController searchController = TextEditingController();
  List<Products> allProducts = [];
  List<Products> filteredProducts = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final response =
          await http.get(Uri.parse('https://dummyjson.com/products/'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          allProducts = (data['products'] as List)
              .map((productJson) => Products.fromJson(productJson))
              .toList();
          filteredProducts = List.from(allProducts);
          isLoading = false;
        });
      } else {
        throw Exception(
            "Failed to load products. Status code: ${response.statusCode}, Body: ${response.body}");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = "Error fetching products: $e";
      });
    }
  }

  void updateSearchResults(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredProducts = List.from(allProducts);
      } else {
        filteredProducts = allProducts
            .where((product) => (product.title?.toLowerCase() ?? '')
                .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Center(child: Text('Product by Category')),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.05,
              child: TextField(
                controller: searchController,
                onChanged: updateSearchResults,
                decoration: InputDecoration(
                  hintText: 'Search for products',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(17),
                    borderSide: const BorderSide(),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(height: height * 0.01),
            Text(
              '${filteredProducts.length} results found',
              style: const TextStyle(color: Colors.grey, fontSize: 15),
            ),
            SizedBox(height: height * 0.01),
            // Product list
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : filteredProducts.isEmpty
                      ? const Center(child: Text('No products found'))
                      : ListView.builder(
                          itemCount: filteredProducts.length,
                          itemBuilder: (context, index) {
                            final product = filteredProducts[index];
                            return ProductbyCategoryContainer(product: product);
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
