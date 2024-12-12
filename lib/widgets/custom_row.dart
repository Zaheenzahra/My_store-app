import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  final String title;
  final String subtitle;
  const CustomRow({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: width * 0.03,
        ),
        Text(subtitle),
      ],
    );
  }
}
