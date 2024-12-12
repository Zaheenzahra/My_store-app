import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_store/modals/prroduct_models.dart';
import 'package:my_store/widgets/iphone_container.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  TextEditingController searchController = TextEditingController();
  late Future<List<Products>> futureProducts;
  List<Products> allProducts = [];
  List<Products> filteredProducts = [];
  int totalProducts = 0;

  @override
  void initState() {
    super.initState();
    futureProducts = fetchProducts();
  }

  // Fetch products from the API
  Future<List<Products>> fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products?limit=100'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      allProducts = (data['products'] as List)
          .map((productJson) => Products.fromJson(productJson))
          .toList();
      filteredProducts = List.from(allProducts);
      totalProducts = allProducts.length;
      return allProducts;
    } else {
      throw Exception("Failed to load products");
    }
  }

  void updateSearchResults(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredProducts = List.from(allProducts);
      } else {
        filteredProducts = allProducts
            .where((product) =>
                product.title?.toLowerCase().contains(query.toLowerCase()) ??
                false)
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
        title: const Center(child: Text('Products')),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            SizedBox(
              height: height * 0.05,
              child: TextField(
                controller: searchController,
                onChanged: updateSearchResults,
                decoration: InputDecoration(
                  hintText: 'Search Products',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(17),
                    borderSide: const BorderSide(),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(height: height * 0.01),

            FutureBuilder(
                future: futureProducts,
                builder: (context, snapshot) {
                  return Text(
                    '$totalProducts results found',
                    style: const TextStyle(color: Colors.grey, fontSize: 15),
                  );
                }),
            SizedBox(height: height * 0.01),
            Expanded(
              child: FutureBuilder<List<Products>>(
                future: futureProducts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No data available'));
                  } else {
                    return ListView.builder(
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return ProductContainer(product: product);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
