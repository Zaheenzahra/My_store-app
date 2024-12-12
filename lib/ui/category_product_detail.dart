import 'package:flutter/material.dart';
import 'package:my_store/modals/single_product_model.dart';
import 'package:my_store/widgets/custom_row.dart';

class CategoryProductDetailScreen extends StatelessWidget {
  final Products product;

  const CategoryProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(product.title ?? 'Product Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            product.thumbnail != null
                ? Image.network(
                    product.thumbnail!,
                    fit: BoxFit.contain,
                    height: height * 0.3,
                    width: double.infinity,
                  )
                : Image.asset(
                    'images/iphone.jpeg',
                    fit: BoxFit.contain,
                    height: height * 0.3,
                    width: double.infinity,
                  ),
            SizedBox(height: height * 0.02),

            // Product Details
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Product Details:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.favorite_outline),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.02),
                  CustomRow(
                    title: 'Name:',
                    subtitle: product.title ?? 'Unknown',
                  ),
                  SizedBox(height: height * 0.01),
                  CustomRow(
                    title: 'Price:',
                    subtitle:
                        '\$${(product.price ?? 0).toDouble().toStringAsFixed(2)}',
                  ),
                  SizedBox(height: height * 0.01),
                  CustomRow(
                    title: 'Category:',
                    subtitle: product.category ?? 'Unknown',
                  ),
                  SizedBox(height: height * 0.01),
                  CustomRow(
                    title: 'Brand:',
                    subtitle: product.brand ?? 'Unknown',
                  ),
                  SizedBox(height: height * 0.01),
                  Row(
                    children: [
                      CustomRow(
                        title: 'Rating:',
                        subtitle:
                            (product.rating ?? 0).toDouble().toStringAsFixed(1),
                      ),
                      ...List.generate(
                        5,
                        (index) => Icon(
                          Icons.star_outlined,
                          color: index < (product.rating ?? 0).round()
                              ? Colors.yellow
                              : const Color.fromARGB(193, 224, 224, 224),
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.01),
                  CustomRow(
                    title: 'Stock:',
                    subtitle: '${product.stock ?? 'N/A'}',
                  ),
                  SizedBox(height: height * 0.01),
                  const Text(
                    'Description:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    product.description ??
                        'No description available for this product.',
                  ),
                  SizedBox(height: height * 0.02),
                  const Text(
                    'Product Gallery:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.2,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: product.images?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Image.network(
                            product.images![index],
                            fit: BoxFit.cover,
                            width: height * 0.2,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
