import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/feature/feed/bloc/feed_bloc.dart';
import 'package:superkauf/feature/feed/view/components/time_ago_widget.dart';
import 'package:superkauf/feature/post_detail/view/components/post_author.dart';
import 'package:superkauf/feature/post_detail/view/components/post_components.dart';
import 'package:superkauf/feature/snackbar/bloc/snackbar_bloc.dart';
import 'package:superkauf/generic/post/bloc/post_bloc.dart';
import 'package:superkauf/generic/post/model/post_model.dart';
import 'package:superkauf/generic/post/view/components/price_widget.dart';
import 'package:superkauf/generic/user/model/user_model.dart';
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
              PopupMenuButton<String>(
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
                    case 'save':
                      {
                        BlocProvider.of<PostBloc>(context).add(
                          SavePost(
                            postId: post.id,
                          ),
                        );
                        BlocProvider.of<SnackbarBloc>(context).add(
                          InfoSnackbar(
                            message: 'post_saved_successfully'.tr(),
                          ),
                        );

                        break;
                      }
                    default:
                      break;
                  }
                },
                itemBuilder: (BuildContext context) {
                  final List<PopupMenuItem<String>> list = [];
                  if (canEdit) {
                    list.add(
                      const PopupMenuItem<String>(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete_outline,
                              color: Colors.black,
                              size: 20,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text('Delete post'),
                          ],
                        ),
                      ),
                    );
                    list.add(
                      const PopupMenuItem<String>(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit,
                              color: Colors.black,
                              size: 20,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text('Edit post'),
                          ],
                        ),
                      ),
                    );
                  }
                  list.add(const PopupMenuItem<String>(
                    value: 'save',
                    child: Row(
                      children: [
                        Icon(
                          Icons.bookmark_border,
                          color: Colors.black,
                          size: 20,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text('Save post'),
                      ],
                    ),
                  ));

                  return list;
                },
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
              Positioned(
                left: 2,
                bottom: 2,
                child: PostDetailLike(
                  post: post,
                ),
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
