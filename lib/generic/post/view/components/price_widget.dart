import 'package:flutter/material.dart';

class PriceWidget extends StatelessWidget {
  final double price;

  const PriceWidget({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.yellowAccent,
      elevation: 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          '${(price % 1 == 0) ? price.toInt().toString() : price.toStringAsFixed(2)} Kč',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 40, color: Colors.black),
        ),
      ),
    );
  }
}
