import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:superkauf/feature/feed/view/components/time_ago_widget.dart';
import 'package:superkauf/feature/home/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:superkauf/feature/post_detail/view/components/reply_button.dart';
import 'package:superkauf/feature/user_detail/bloc/user_detail_bloc.dart';
import 'package:superkauf/generic/comments/bloc/comment_bloc.dart';
import 'package:superkauf/generic/comments/model/post_comment_model.dart';
import 'package:superkauf/generic/user/model/user_model.dart';
import 'package:superkauf/generic/user/view/username_label.dart';

class CommentContainer extends StatefulWidget {
  final PostCommentModel comment;
  final int postId;
  final UserModel? currentUser;

  const CommentContainer({
    super.key,
    required this.comment,
    required this.currentUser,
    required this.postId,
  });

  @override
  State<CommentContainer> createState() => _CommentContainerState();
}

class _CommentContainerState extends State<CommentContainer> {
  final GlobalKey _widgetKey = GlobalKey();
  var likes = 0;

  @override
  void initState() {
    likes = widget.comment.comment.likes;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: _widgetKey,
      onLongPress: () {
        if (widget.currentUser == null || (widget.currentUser!.id != widget.comment.user.id && !widget.currentUser!.isAdmin)) {
          return;
        }
        final RenderBox renderBox = _widgetKey.currentContext!.findRenderObject() as RenderBox;

        showMenu(
          context: context,
          position: RelativeRect.fromRect(
            Rect.fromPoints(
              renderBox.localToGlobal(Offset.zero),
              renderBox.localToGlobal(renderBox.size.bottomRight(Offset.zero)),
            ),
            Offset.zero & MediaQuery.of(context).size,
          ),
          items: <PopupMenuEntry>[
            PopupMenuItem<String>(
                value: 'delete',
                child: const Text('Delete comment'),
                onTap: () {
                  BlocProvider.of<CommentBloc>(context).add(DeleteCommentEvent(post: widget.comment, postId: widget.postId));
                }),
          ],
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  BlocProvider.of<UserDetailBloc>(context).add(GetUser(userID: widget.comment.user.id));
                  BlocProvider.of<NavigationBloc>(context).add(const OpenUserDetailScreen());
                },
                child: CircleAvatar(
                  radius: 16,
                  backgroundImage: CachedNetworkImageProvider(widget.comment.user.profilePicture),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UsernameLabel(user: widget.comment.user),
                  const Gap(
                    2,
                  ),
                  GetCommentSubtype(reaction: widget.comment.comment.reaction?.type)
                ],
              ),
              const Spacer(),
              TimeAgoWidget(dateTime: widget.comment.comment.createdAt),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 42),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  //:sob:
                  widget.comment.comment.comment,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                GestureDetector(
                  onTap: () async {
                    BlocProvider.of<CommentBloc>(context).add(LikeCommentEvent(
                      comment: widget.comment.comment.id,
                      postId: widget.postId,
                    ));
                    if (likes == widget.comment.comment.likes) {
                      setState(() {
                        likes++;
                      });
                    }
                  },
                  child: Column(
                    children: [
                      const FaIcon(FontAwesomeIcons.heart, size: 16),
                      const Gap(2),
                      Text(
                        likes.toString(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 42),
            child: ReplyButton(postId: widget.postId, parentComment: widget.comment),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class GetCommentSubtype extends StatelessWidget {
  final String? reaction;
  const GetCommentSubtype({
    super.key,
    required this.reaction,
  });

  @override
  Widget build(BuildContext context) {
    if (reaction == null) return const SizedBox.shrink();
    switch (reaction) {
      case 'bought':
        return Text('mark_comment_as_bought'.tr(), style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.green));
      case 'not_on_sale':
        return Text('mark_comment_sale_end'.tr(), style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.red));
      case 'sold_out':
        return Text('mark_comment_as_sold_out'.tr(), style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.orange));
      default:
        return const SizedBox.shrink();
    }
    ;
  }
}
