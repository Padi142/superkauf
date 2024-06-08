import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:superkauf/feature/post_detail/bloc/post_detail_bloc.dart';
import 'package:superkauf/generic/comments/bloc/comment_bloc.dart';
import 'package:superkauf/generic/comments/model/post_comment_model.dart';
import 'package:superkauf/generic/widget/app_text_field/app_text_field.dart';
import 'package:superkauf/generic/widget/app_text_field/validator_empty.dart';
import 'package:superkauf/generic/widget/app_text_field/validator_regex.dart';

class ReplyButton extends StatefulWidget {
  final int postId;
  final PostCommentModel parentComment;

  const ReplyButton({
    super.key,
    required this.postId,
    required this.parentComment,
  });

  @override
  State<ReplyButton> createState() => _ReplyButtonState();
}

class _ReplyButtonState extends State<ReplyButton> {
  var isShown = false;
  var lines = 1;
  var sendButtonClicked = false;
  TextEntryModel commentModel = TextEntryModel();

  @override
  Widget build(BuildContext context) {
    return isShown
        ? LayoutBuilder(builder: (context, constrains) {
            return Row(
              children: [
                SizedBox(
                  width: constrains.maxWidth * 0.76,
                  child: AppTextField(
                    commentModel,
                    context: context,
                    hint: 'comment_create_label'.tr(),
                    filled: Theme.of(context).colorScheme.surface,
                    radius: 16,
                    lines: lines,
                    beginEdit: (value) {
                      setState(() {
                        lines = 4;
                      });
                    },
                    endEdit: (value) {
                      setState(() {
                        lines = 1;
                      });
                    },
                    validators: [ValidatorEmpty(), ValidatorRegex(r'^.{1,250}$', 'Comment is too long')],
                  ),
                ),
                IconButton(
                    iconSize: 18,
                    onPressed: () async {
                      if (sendButtonClicked) {
                        return;
                      }

                      commentModel.controller.text.trim();
                      final valid = await TextEntryModel.validateFields([commentModel]);
                      if (!valid) {
                        setState(() {});
                        return;
                      }

                      sendButtonClicked = true;

                      BlocProvider.of<CommentBloc>(context).add(
                        ReplyCommentEvent(
                          postId: widget.postId,
                          comment: commentModel.text,
                          commentId: widget.parentComment.comment.parentId ?? widget.parentComment.comment.id,
                        ),
                      );

                      BlocProvider.of<PostDetailBloc>(context).add(
                        GetPost(postId: widget.postId.toString()),
                      );
                    },
                    icon: const FaIcon(FontAwesomeIcons.paperPlane))
              ],
            );
          })
        : GestureDetector(
            onTap: () {
              setState(() {
                isShown = true;
              });
            },
            child: Text('reply_button_label'.tr()));
  }
}
