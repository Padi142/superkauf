import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:superkauf/library/app.dart';

class RequiresStoreCard extends StatelessWidget {
  const RequiresStoreCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      triggerMode: TooltipTriggerMode.tap,
      message: 'post_store_card_required'.tr(),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Padding(
          padding: EdgeInsets.all(6),
          child: Icon(
            Icons.add_card,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class StoreNameIcon extends StatelessWidget {
  final String storeName;
  const StoreNameIcon({super.key, required this.storeName});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Text(
          storeName,
          style: App.appTheme.textTheme.bodyMedium,
        ),
      ),
    );
  }
}

class HeartReaction extends StatelessWidget {
  final int reactions;
  final bool isClicked;
  const HeartReaction({super.key, required this.reactions, required this.isClicked});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isClicked
          ? BoxDecoration(
              color: Colors.pinkAccent.withOpacity(0.8),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.pinkAccent, width: 2),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 4),
                  blurRadius: 4,
                  color: Colors.pinkAccent.withOpacity(0.25),
                ),
              ],
            )
          : BoxDecoration(
              color: Colors.grey.withOpacity(0.8),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey, width: 2),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 4),
                  blurRadius: 4,
                  color: Colors.grey.withOpacity(0.25),
                ),
              ],
            ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            const Icon(
              Icons.favorite,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              reactions.toString(),
              style: App.appTheme.textTheme.titleSmall!.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeedContainerPrice extends StatelessWidget {
  final double price;
  const FeedContainerPrice({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Colors.yellowAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          '${(price % 1 == 0) ? price.toInt().toString() : price.toStringAsFixed(2)} Kč',
          style: App.appTheme.textTheme.titleLarge,
        ),
      ),
    );
  }
}
