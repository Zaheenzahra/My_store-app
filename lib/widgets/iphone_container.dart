import 'package:flutter/material.dart';
import 'package:my_store/modals/prroduct_models.dart';
import 'package:my_store/ui/product_detail.dart';

class ProductContainer extends StatelessWidget {
  final Products product;

  const ProductContainer({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: height * 0.4,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.01),
              product.thumbnail != null
                  ? Image.network(
                      product.thumbnail!,
                      height: height * 0.2,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Image.asset('images/iphone.jpeg'),
              SizedBox(height: height * 0.01),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(
                        product: product,
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        product.title ?? 'Unknown Product',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Text(
                      '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    '${product.rating?.toStringAsFixed(1) ?? '0.0'} ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ...List.generate(
                    5,
                    (index) => Icon(
                      Icons.star_outlined,
                      color: index < (product.rating ?? 0).round()
                          ? Colors.yellow
                          : Colors.grey.shade300,
                      size: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.01),
              Text(
                'By ${product.brand ?? 'Unknown Brand'}',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: height * 0.01),
              Text(
                product.category ?? 'Unknown Category',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
