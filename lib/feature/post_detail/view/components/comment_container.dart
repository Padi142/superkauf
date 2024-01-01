import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/feature/feed/view/components/time_ago_widget.dart';
import 'package:superkauf/feature/home/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:superkauf/feature/user_detail/bloc/user_detail_bloc.dart';
import 'package:superkauf/generic/comments/bloc/comment_bloc.dart';
import 'package:superkauf/generic/comments/model/post_comment_model.dart';
import 'package:superkauf/generic/user/model/user_model.dart';
import 'package:superkauf/generic/user/view/username_label.dart';
import 'package:superkauf/library/app.dart';

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
                  radius: 20,
                  backgroundImage: CachedNetworkImageProvider(widget.comment.user.profilePicture),
                ),
              ),
              const SizedBox(width: 10),
              UsernameLabel(user: widget.comment.user),
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
            padding: const EdgeInsets.all(8),
            child: SelectableText(
              //:sob:
              widget.comment.comment.comment,
              textAlign: TextAlign.start,
              style: App.appTheme.textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
