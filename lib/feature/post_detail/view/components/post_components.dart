import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/feature/home/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:superkauf/generic/functions.dart';
import 'package:superkauf/generic/post/bloc/post_bloc.dart';
import 'package:superkauf/generic/post/model/post_model.dart';

class StoreLabel extends StatelessWidget {
  final String storeLabel;
  final int storeId;

  const StoreLabel({
    super.key,
    required this.storeLabel,
    required this.storeId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          BlocProvider.of<NavigationBloc>(context)
              .add(OpenStoresScreen(null, storeId: storeId));
          Navigator.of(context).pop();
        },
        child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 4),
                  blurRadius: 4,
                  color: Colors.black.withOpacity(0.25),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(storeLabel,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.white,
                      )),
            )),
      ),
    );
  }
}

class CardRequired extends StatelessWidget {
  const CardRequired({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 4,
                color: Colors.black.withOpacity(0.25),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('post_store_card_required'.tr(),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white,
                    )),
          )),
    );
  }
}

class FeedPostValidUntilLabel extends StatelessWidget {
  final DateTime validUntil;

  const FeedPostValidUntilLabel({super.key, required this.validUntil});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'sale_ends_in_label'.tr(),
      triggerMode: TooltipTriggerMode.tap,
      child: Card(
        elevation: 4,
        color: validUntil
                    .difference(DateTime(DateTime.now().year,
                        DateTime.now().month, DateTime.now().day))
                    .inDays >
                3
            ? Colors.white
            : Colors.redAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            getDaysUntilString(validUntil),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ),
    );
  }
}

class PostDetailLike extends StatefulWidget {
  final PostModel post;
  final bool isLiked;

  const PostDetailLike({
    super.key,
    required this.post,
    required this.isLiked,
  });

  @override
  State<PostDetailLike> createState() => _PostDetailLikeState();
}

var isLiked = false;

class _PostDetailLikeState extends State<PostDetailLike> {
  @override
  void initState() {
    isLiked = widget.isLiked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
          onTap: () {
            if (isLiked) {
              BlocProvider.of<PostBloc>(context)
                  .add(RemoveReaction(postId: widget.post.id));
              setState(() {
                isLiked = false;
              });
            } else {
              BlocProvider.of<PostBloc>(context)
                  .add(AddReaction(postId: widget.post.id));
              setState(() {
                isLiked = true;
              });
            }
          },
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: isLiked
                ? Container(
                    decoration: BoxDecoration(
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
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.favorite,
                              color: Colors.white,
                              size: 30,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              widget.post.likes.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        )),
                  )
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 4),
                          blurRadius: 4,
                          color: Colors.black.withOpacity(0.25),
                        ),
                      ],
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.favorite_border,
                              color: Colors.black,
                              size: 30,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              widget.post.likes.toString(),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        )),
                  ),
          )),
    );
  }
}
