import 'package:flutter/material.dart';
import 'package:my_store/modals/prroduct_models.dart';
import 'package:my_store/provider/favourite_provider.dart';
import 'package:my_store/widgets/custom_row.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final Products product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.product.title ?? 'Product Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.product.thumbnail != null
                ? Image.network(
                    widget.product.thumbnail!,
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
                      Consumer<FavouriteProvider>(
                        builder: (context, favouriteProvider, child) {
                          bool isFavorite =
                              favouriteProvider.isFavorite(widget.product);

                          return IconButton(
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite ? Colors.red : null,
                            ),
                            onPressed: () {
                              if (isFavorite) {
                                favouriteProvider.removeItem(widget.product);
                              } else {
                                favouriteProvider.addItem(widget.product);
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.02),
                  CustomRow(
                    title: 'Name:',
                    subtitle: widget.product.title ?? 'Unknown',
                  ),
                  SizedBox(height: height * 0.01),
                  CustomRow(
                    title: 'Price:',
                    subtitle:
                        '\$${(widget.product.price ?? 0).toDouble().toStringAsFixed(2)}',
                  ),
                  SizedBox(height: height * 0.01),
                  CustomRow(
                    title: 'Category:',
                    subtitle: widget.product.category ?? 'Unknown',
                  ),
                  SizedBox(height: height * 0.01),
                  CustomRow(
                    title: 'Brand:',
                    subtitle: widget.product.brand ?? 'Unknown',
                  ),
                  SizedBox(height: height * 0.01),
                  Row(
                    children: [
                      CustomRow(
                        title: 'Rating:',
                        subtitle: (widget.product.rating ?? 0)
                            .toDouble()
                            .toStringAsFixed(1),
                      ),
                      ...List.generate(
                        5,
                        (index) => Icon(
                          Icons.star_outlined,
                          color: index < (widget.product.rating ?? 0).round()
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
                    subtitle: '${widget.product.stock ?? 'N/A'}',
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
                    widget.product.description ??
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
                      itemCount: widget.product.images?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Image.network(
                            widget.product.images![index],
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
