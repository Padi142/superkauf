import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:superkauf/feature/post_detail/bloc/post_detail_bloc.dart';
import 'package:superkauf/generic/comments/bloc/comment_bloc.dart';
import 'package:superkauf/generic/comments/bloc/comment_state.dart';
import 'package:superkauf/generic/post/model/post_model.dart';
import 'package:superkauf/generic/widget/app_button.dart';
import 'package:superkauf/generic/widget/app_text_field/index.dart';

class AddCommentField extends StatefulWidget {
  final PostModel post;
  final Function() onStartEdit;

  const AddCommentField({
    super.key,
    required this.post,
    required this.onStartEdit,
  });

  @override
  State<AddCommentField> createState() => _AddCommentFieldState();
}

class _AddCommentFieldState extends State<AddCommentField> {
  TextEntryModel commentModel = TextEntryModel();
  var lines = 1;
  var sendButtonClicked = false;
  final interactions = [
    PopupOption(value: 'bought', title: 'mark_comment_as_bought'.tr()),
    PopupOption(value: 'not_on_sale', title: 'mark_comment_sale_end'.tr()),
    PopupOption(value: 'sold_out', title: 'mark_comment_as_sold_out'.tr())
  ];
  PopupOption? selectedInteraction;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommentBloc, CommentState>(
      listener: (context, state) {
        state.maybeMap(
            success: (success) {
              setState(() {
                commentModel.controller.text = '';
                sendButtonClicked = false;
              });
            },
            orElse: () {});
      },
      child: LayoutBuilder(builder: (context, constrains) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const FaIcon(FontAwesomeIcons.commentDots),
            // const SizedBox(width: 5),
            SizedBox(
              width: constrains.maxWidth * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppTextField(
                    commentModel,
                    context: context,
                    hint: 'comment_create_label'.tr(),
                    filled: Theme.of(context).colorScheme.surface,
                    radius: 16,
                    lines: lines,
                    beginEdit: (value) {
                      widget.onStartEdit();
                      setState(() {
                        lines = 7;
                      });
                    },
                    endEdit: (value) {
                      setState(() {
                        lines = 1;
                      });
                    },
                    validators: [ValidatorEmpty(), ValidatorRegex(r'^.{1,250}$', 'Comment is too long')],
                  ),
                  const SizedBox(height: 2),
                  SizedBox(
                    width: constrains.maxWidth * 0.4,
                    child: AppButton(
                      backgroundColor: getColorForInteraction(selectedInteraction?.value),
                      text: selectedInteraction != null ? selectedInteraction!.title : 'Mark comment',
                      textStyle: Theme.of(context).textTheme.titleSmall,
                      radius: 8,
                      popupMenu: interactions,
                      onSelectPopup: (value) {
                        setState(() {
                          selectedInteraction = value;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: IconButton(
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
                      CreateCommentEvent(
                        postId: widget.post.id,
                        comment: commentModel.text,
                        reaction: selectedInteraction?.value,
                      ),
                    );

                    BlocProvider.of<PostDetailBloc>(context).add(
                      GetPost(postId: widget.post.id.toString()),
                    );
                  },
                  icon: const FaIcon(FontAwesomeIcons.paperPlane)),
            )
          ],
        );
      }),
    );
  }

  Color getColorForInteraction(String? interaction) {
    switch (interaction) {
      case 'bought':
        return Colors.green;
      case 'not_on_sale':
        return Colors.red;
      case 'sold_out':
        return Colors.orange;
      default:
        return Theme.of(context).colorScheme.surface;
    }
  }
}
