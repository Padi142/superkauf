import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:superkauf/feature/post_detail/view/components/add_comment_field.dart';
import 'package:superkauf/feature/post_detail/view/components/comment_section.dart';
import 'package:superkauf/feature/post_detail/view/components/edit_description_field.dart';
import 'package:superkauf/feature/post_detail/view/components/post_components.dart';
import 'package:superkauf/generic/post/model/post_model.dart';
import 'package:superkauf/library/app.dart';

class PostDetailDescription extends StatelessWidget {
  final BoxConstraints constraints;
  final PostModel post;
  final ScrollController scrollController;
  final Function(String newDescription) onDone;
  final bool startEdit;

  const PostDetailDescription({
    super.key,
    required this.constraints,
    required this.post,
    required this.scrollController,
    required this.onDone,
    required this.startEdit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: constraints.maxWidth * 0.95,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: startEdit
                  ? EditDescriptionField(post: post, onDone: onDone)
                  : SelectableText(
                      post.description,
                      style: App.appTheme.textTheme.bodyLarge,
                    ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          AddCommentField(
            post: post,
            onStartEdit: () {
              scrollController.animateTo(
                scrollController.offset + 200,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            },
          ),
          const SizedBox(
            height: 40,
          ),
          Text('post_tags_label'.tr(),
              style: App.appTheme.textTheme.titleSmall),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                StoreLabel(storeLabel: post.storeName, storeId: post.store),
                post.requiresStoreCard
                    ? const CardRequired()
                    : const SizedBox(),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text('post_comments_label'.tr(),
              style: App.appTheme.textTheme.titleSmall),
          const SizedBox(
            height: 20,
          ),
          CommentSection(
            post: post,
            scrollController: scrollController,
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
