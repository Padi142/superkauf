import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/feature/feed/view/components/time_ago_widget.dart';
import 'package:superkauf/feature/home/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:superkauf/feature/post_detail/bloc/post_detail_bloc.dart';
import 'package:superkauf/feature/user_detail/bloc/user_detail_bloc.dart';
import 'package:superkauf/generic/notifications/model/models/notification_model.dart';
import 'package:superkauf/library/app.dart';

class NotificationContainer extends StatelessWidget {
  final NotificationModel notification;

  const NotificationContainer({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    switch (notification.type) {
      case NotificationType.post_like:
        return _buildPostLikeNotification(context);
      case NotificationType.post_comment:
        return _buildPostCommentNotification(context);
      default:
        return Container();
    }
  }

  Widget _buildPostLikeNotification(BuildContext context) {
    return ListTile(
      onTap: () {
        BlocProvider.of<PostDetailBloc>(context).add(InitialEvent(post: notification.relatedPost, user: notification.relatedUser));

        BlocProvider.of<NavigationBloc>(context).add(const OpenPostDetailScreen());
      },
      tileColor: notification.seen ? App.appTheme.scaffoldBackgroundColor : Colors.grey[200],
      leading: GestureDetector(
        onTap: () {
          BlocProvider.of<UserDetailBloc>(context).add(GetUser(userID: notification.relatedUserId));
          BlocProvider.of<NavigationBloc>(context).add(const OpenUserDetailScreen());
        },
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(notification.relatedUser.profilePicture),
          ),
        ),
      ),
      title: Text(notification.text),
      subtitle: TimeAgoWidget(
        dateTime: notification.createdAt,
      ),
      trailing: Padding(
        padding: const EdgeInsets.all(4),
        child: CachedNetworkImage(
          imageUrl: notification.relatedPost.image,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }

  Widget _buildPostCommentNotification(BuildContext context) {
    return ListTile(
      onTap: () {
        BlocProvider.of<PostDetailBloc>(context).add(InitialEvent(post: notification.relatedPost, user: notification.relatedUser));

        BlocProvider.of<NavigationBloc>(context).add(const OpenPostDetailScreen());
      },
      tileColor: notification.seen ? App.appTheme.scaffoldBackgroundColor : Colors.grey[200],
      leading: GestureDetector(
        onTap: () {
          BlocProvider.of<UserDetailBloc>(context).add(GetUser(userID: notification.relatedUserId));
          BlocProvider.of<NavigationBloc>(context).add(const OpenUserDetailScreen());
        },
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(notification.relatedUser.profilePicture),
          ),
        ),
      ),
      title: Text(notification.text),
      subtitle: TimeAgoWidget(
        dateTime: notification.createdAt,
      ),
      trailing: Padding(
        padding: const EdgeInsets.all(4),
        child: CachedNetworkImage(
          imageUrl: notification.relatedPost.image,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
