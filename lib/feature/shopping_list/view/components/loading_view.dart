import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';

class ShoppingListLoadingView extends StatelessWidget {
  final BoxConstraints constraints;

  const ShoppingListLoadingView({
    super.key,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: constraints.maxWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: constraints.maxHeight * 0.9,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(4),
                  child: ListTile(
                    leading: CardLoading(
                      height: 80,
                      borderRadius: BorderRadius.circular(8),
                      width: constraints.maxWidth * 0.8,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
