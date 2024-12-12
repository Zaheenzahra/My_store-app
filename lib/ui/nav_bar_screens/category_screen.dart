import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_store/modals/category_model.dart';
import 'package:my_store/ui/item_by_category.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<CategoryModel> categoryList = [];
  List<CategoryModel> filteredCategoryList = [];
  int totalCategories = 0;

  Future<List<CategoryModel>> getCategoryApi() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products/categories'));

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      categoryList = (data as List)
          .map((categoryJson) => CategoryModel.fromJson(categoryJson))
          .toList();
      filteredCategoryList = List.from(categoryList);
      totalCategories = categoryList.length;
      return categoryList;
    } else {
      return [];
    }
  }

  TextEditingController searchController = TextEditingController();

  void updateSearchResults(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredCategoryList = List.from(categoryList);
      } else {
        filteredCategoryList = categoryList
            .where((category) =>
                category.name!.toLowerCase().contains(query.toLowerCase()))
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
        title: const Center(child: Text('Categories')),
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search bar
          SizedBox(
            height: height * 0.05,
            child: TextField(
              controller: searchController,
              onChanged: updateSearchResults,
              decoration: InputDecoration(
                hintText: 'Search categories',
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
            future: getCategoryApi(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Failed to load categories'));
              } else {
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    '$totalCategories results found',
                    style: const TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                );
              }
            },
          ),
          SizedBox(height: height * 0.01),
          Expanded(
            child: FutureBuilder(
              future: getCategoryApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Failed to load categories'));
                } else {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: filteredCategoryList.length,
                    itemBuilder: (context, index) {
                      var category = filteredCategoryList[index];
                      return Card(
                        elevation: 5,
                        margin: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ProductbyCategoryScreen(),
                              ),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                category.name ?? 'Category ${index + 1}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                category.slug ?? '',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
