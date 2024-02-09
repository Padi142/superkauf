import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:superkauf/feature/feed/view/components/time_ago_widget.dart';
import 'package:superkauf/feature/post_detail/view/components/post_action_buttons.dart';
import 'package:superkauf/feature/post_detail/view/components/post_author.dart';
import 'package:superkauf/feature/post_detail/view/components/post_components.dart';
import 'package:superkauf/generic/post/model/post_model.dart';
import 'package:superkauf/generic/post/view/components/price_widget.dart';
import 'package:superkauf/generic/user/model/user_model.dart';
import 'package:superkauf/generic/widget/app_progress.dart';
import 'package:superkauf/library/app.dart';

class PostDetailViewComponent extends StatelessWidget {
  final BoxConstraints constraints;
  final PostModel post;
  final UserModel user;
  final Function() onDescriptionEdit;
  final bool isLiked;
  final bool canEdit;

  const PostDetailViewComponent({
    super.key,
    required this.constraints,
    required this.post,
    required this.user,
    required this.onDescriptionEdit,
    required this.isLiked,
    required this.canEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: constraints.maxWidth * 95,
          child: Row(
            children: [
              PostAuthor(
                user: user,
              ),
              const Spacer(),
              TimeAgoWidget(
                dateTime: post.createdAt,
              ),
              PostActionButtons(
                post: post,
                onDescriptionEdit: onDescriptionEdit,
                canEdit: canEdit,
              )
            ],
          ),
        ),
        SizedBox(
          height: constraints.maxHeight * 0.55,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  showImageViewer(context, Image.network(post.image).image, onViewerDismissed: () {});
                },
                child: Hero(
                  tag: post.id,
                  child: Container(
                    color: App.appTheme.colorScheme.surface,
                    child: CachedNetworkImage(
                      imageUrl: post.image,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fitHeight,
                        )),
                      ),
                      placeholder: (context, url) => const Center(child: Center(child: CircularProgressIndicator())),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 1,
                bottom: 1,
                child: Hero(tag: 'price${post.id}', child: PriceWidget(price: post.price)),
              ),
              post.validUntil != null
                  ? Positioned(
                      left: 2,
                      top: 2,
                      child: FeedPostValidUntilLabel(
                        validUntil: post.validUntil!,
                      ),
                    )
                  : const SizedBox(),
              Positioned(
                left: 2,
                bottom: 2,
                child: PostDetailLike(
                  post: post,
                  isLiked: isLiked,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class InitialPostDetailViewComponent extends StatelessWidget {
  final BoxConstraints constraints;
  final PostModel post;
  final UserModel user;

  const InitialPostDetailViewComponent({
    super.key,
    required this.constraints,
    required this.post,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: constraints.maxWidth * 95,
          child: Row(
            children: [
              PostAuthor(
                user: user,
              ),
              const Spacer(),
              TimeAgoWidget(
                dateTime: post.createdAt,
              ),
            ],
          ),
        ),
        SizedBox(
          height: constraints.maxHeight * 0.55,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  showImageViewer(context, Image.network(post.image).image, onViewerDismissed: () {});
                },
                child: Hero(
                  tag: post.id,
                  child: Container(
                    color: App.appTheme.colorScheme.surface,
                    child: CachedNetworkImage(
                      imageUrl: post.image,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fitHeight,
                        )),
                      ),
                      placeholder: (context, url) => const Center(child: Center(child: CircularProgressIndicator())),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 1,
                bottom: 1,
                child: Hero(tag: 'price${post.id}', child: PriceWidget(price: post.price)),
              ),
              post.validUntil != null
                  ? Positioned(
                      left: 2,
                      top: 2,
                      child: FeedPostValidUntilLabel(
                        validUntil: post.validUntil!,
                      ),
                    )
                  : const SizedBox(),
              const Positioned(
                left: 2,
                bottom: 2,
                child: AppProgress(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
