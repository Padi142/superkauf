import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/feature/feed/bloc/feed_bloc.dart';
import 'package:superkauf/feature/home/bloc/saved_posts_panel_bloc/saved_posts_panel_bloc.dart';
import 'package:superkauf/feature/snackbar/bloc/snackbar_bloc.dart';
import 'package:superkauf/generic/post/bloc/post_bloc.dart';
import 'package:superkauf/generic/post/model/post_model.dart';

class PostActionButtons extends StatelessWidget {
  final PostModel post;
  final Function() onDescriptionEdit;
  final bool canEdit;
  const PostActionButtons({
    super.key,
    required this.post,
    required this.onDescriptionEdit,
    required this.canEdit,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
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
          case 'edit_valid_until':
            {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now().subtract(const Duration(days: 1)),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (picked != null) {
                BlocProvider.of<PostBloc>(context).add(
                  UpdatePostValidUntilEvent(
                    postId: post.id,
                    newValidUntil: picked,
                  ),
                );
              }
              break;
            }
          case 'save':
            {
              BlocProvider.of<PostBloc>(context).add(
                SavePost(
                  postId: post.id,
                ),
              );
              BlocProvider.of<SavedPostsPanelBloc>(context).add(OpenSavedPostsPanel(
                storeId: post.store,
                postId: post.id,
              ));
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

          list.add(
            const PopupMenuItem<String>(
              value: 'edit_valid_until',
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
                  Text('Edit sale end'),
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
