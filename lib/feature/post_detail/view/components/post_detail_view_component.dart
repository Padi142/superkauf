import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/feature/feed/bloc/feed_bloc.dart';
import 'package:superkauf/feature/feed/view/components/time_ago_widget.dart';
import 'package:superkauf/feature/post_detail/view/components/post_author.dart';
import 'package:superkauf/generic/post/bloc/post_bloc.dart';
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
  final bool canEdit;

  const PostDetailViewComponent({
    super.key,
    required this.constraints,
    required this.post,
    required this.user,
    required this.onDescriptionEdit,
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
              canEdit
                  ? PopupMenuButton<String>(
                      icon: const Icon(
                        Icons.more_vert,
                      ),
                      // Icon for three dots
                      onSelected: (String value) async {
                        switch (value) {
                          case 'delete':
                            {
                              _showConfirmDeletion(context, () {
                                BlocProvider.of<PostBloc>(context).add(DeletePost(postId: post.id.toString(), author: post.author));
                                BlocProvider.of<FeedBloc>(context).add(const ReloadFeed());
                                Navigator.of(context).pop();
                              });

                              break;
                            }
                          case 'edit':
                            {
                              onDescriptionEdit();
                              break;
                            }
                          default:
                            break;
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem<String>(
                          value: 'delete',
                          child: Text('Delete post'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'edit',
                          child: Text('Edit post'),
                        ),
                      ],
                    )
                  : const SizedBox(
                      width: 10,
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
                      placeholder: (context, url) => const Center(child: AppProgress()),
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
            ],
          ),
        ),
      ],
    );
  }

  void _showConfirmDeletion(BuildContext context, Function() onDone) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          child: AlertDialog(
            title: const Text('Do you really want to delete this post?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  onDone();
                  Navigator.of(context).pop();
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        );
      },
    );
  }
}
