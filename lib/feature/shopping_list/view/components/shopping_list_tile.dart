import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:superkauf/library/app.dart';

class ShoppingListTile extends StatelessWidget {
  final String image;
  final String name;
  final int items;
  final BoxConstraints constraints;
  final Function() onTap;
  const ShoppingListTile({
    super.key,
    required this.image,
    required this.name,
    required this.onTap,
    required this.items,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Material(
        elevation: 4, // Adjust the elevation as needed
        borderRadius: BorderRadius.circular(6),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          // Adjust the radius as needed
          child: CachedNetworkImage(
            height: 40,
            width: 80,
            imageUrl: image,
            fit: BoxFit.fitWidth,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
      title: Text(
        name,
        style: App.appTheme.textTheme.titleMedium,
      ),
      trailing: SizedBox(
        width: constraints.maxWidth * 0.2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              '$items items',
            ),
            const Gap(8),
            const FaIcon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
          ],
        ),
      ),
      onTap: () {
        onTap();
      },
    );
  }
}
