import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:superkauf/generic/shopping_list/model/shopping_list_model.dart';
import 'package:superkauf/generic/store/model/store_model.dart';
import 'package:superkauf/library/app.dart';

class SavedPostListTile extends StatefulWidget {
  final ShoppingListModel list;
  final int postId;
  final Function(bool) onTap;
  final bool isSaved;

  const SavedPostListTile({
    super.key,
    required this.list,
    required this.postId,
    required this.onTap,
    required this.isSaved,
  });

  @override
  State<SavedPostListTile> createState() => _SavedPostListTileState();
}

var isClicked = false;

class _SavedPostListTileState extends State<SavedPostListTile> {
  @override
  void initState() {
    isClicked = widget.isSaved;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.list.name,
        style: App.appTheme.textTheme.titleMedium,
      ),
      leading: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(6),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          // Adjust the radius as needed
          child: CachedNetworkImage(
            height: 40,
            width: 80,
            imageUrl: widget.list.logo,
            fit: BoxFit.fitWidth,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
      trailing: GestureDetector(
        onTap: () {
          setState(() {
            isClicked = !isClicked;
          });
          widget.onTap(isClicked);
        },
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: isClicked
              ? FaIcon(
                  FontAwesomeIcons.circleCheck,
                  color: Colors.greenAccent,
                  key: UniqueKey(),
                )
              : FaIcon(
                  FontAwesomeIcons.circlePlus,
                  key: UniqueKey(),
                ),
        ),
      ),
      onTap: () {
        setState(() {
          isClicked = !isClicked;
        });
        widget.onTap(isClicked);
      },
    );
  }
}

class StoreSavedPostTile extends StatelessWidget {
  final StoreModel store;

  const StoreSavedPostTile({super.key, required this.store});

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
            imageUrl: store.image,
            fit: BoxFit.fitWidth,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
      title: Text(
        store.name,
        style: App.appTheme.textTheme.titleMedium,
      ),
      trailing: FaIcon(
        FontAwesomeIcons.circleCheck,
        color: Colors.greenAccent,
        key: UniqueKey(),
      ),
      onTap: () {},
    );
  }
}
