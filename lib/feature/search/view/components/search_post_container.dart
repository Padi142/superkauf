import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/feature/feed/view/components/post_icons.dart';
import 'package:superkauf/feature/feed/view/components/post_image.dart';
import 'package:superkauf/feature/home/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:superkauf/feature/post_detail/bloc/post_detail_bloc.dart';
import 'package:superkauf/feature/search/models/search_post_model.dart';

class SearchPostContainer extends StatelessWidget {
  final SearchPostModel post;
  final BoxConstraints constraints;

  const SearchPostContainer({super.key, required this.post, required this.constraints});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {},
      onTap: () {
        BlocProvider.of<PostDetailBloc>(context).add(InitialEvent(
          postId: post.id,
        ));
        BlocProvider.of<NavigationBloc>(context).add(const OpenPostDetailScreen());
      },
      child: Card(
        elevation: 7,
        child: Padding(
          padding: const EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 6),
          child: Column(
            children: [
              SizedBox(
                height: 280,
                child: Stack(
                  children: [
                    FeedPostImage(
                      postImage: post.image,
                      id: post.id,
                      constraints: constraints,
                    ),
                    Positioned(
                      right: 2,
                      top: 4,
                      child: StoreNameIcon(
                        storeName: post.storeName,
                      ),
                    ),
                    Positioned(
                      right: 2,
                      bottom: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Hero(
                            tag: 'price${post.id}',
                            child: FeedContainerPrice(
                              price: post.price ?? 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: SizedBox(
                          width: constraints.maxWidth * 0.79,
                          child: Text(
                            post.description,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
