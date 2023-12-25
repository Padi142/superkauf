import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/feature/post_detail/view/components/comment_container.dart';
import 'package:superkauf/feature/snackbar/bloc/snackbar_bloc.dart';
import 'package:superkauf/generic/comments/bloc/comment_bloc.dart';
import 'package:superkauf/generic/comments/bloc/comment_state.dart';
import 'package:superkauf/generic/post/model/post_model.dart';
import 'package:superkauf/generic/widget/app_progress.dart';
import 'package:superkauf/library/app.dart';

class CommentSection extends StatefulWidget {
  final PostModel post;
  final ScrollController scrollController;
  const CommentSection({super.key, required this.post, required this.scrollController});

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  @override
  void initState() {
    BlocProvider.of<CommentBloc>(context).add(GetCommentsForPost(postId: widget.post.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(builder: (context, state) {
      return state.maybeMap(success: (success) {
        if (success.comments.isEmpty) {
          return Center(
            child: Text('no_comments_label'.tr(), style: App.appTheme.textTheme.titleMedium),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: success.comments.length,
          itemBuilder: (context, index) {
            return CommentContainer(
              comment: success.comments[index],
              postId: widget.post.id,
              currentUser: success.currentUser,
            );
          },
        );
      }, error: (error) {
        BlocProvider.of<SnackbarBloc>(context).add(ErrorSnackbar(message: error.error));
        return const SizedBox();
      }, orElse: () {
        return const Center(child: AppProgress());
      });
    });
  }
}
