import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:superkauf/feature/feed/view/components/time_ago_widget.dart';
import 'package:superkauf/feature/home/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:superkauf/feature/post_detail/bloc/post_detail_bloc.dart';
import 'package:superkauf/feature/user_detail/bloc/user_detail_bloc.dart';
import 'package:superkauf/generic/notifications/model/models/notification_model.dart';
import 'package:superkauf/library/app.dart';
import 'package:url_launcher/url_launcher.dart';

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
      case NotificationType.highlight:
        return _buildPostHighlightNotification(context);
      case NotificationType.link:
        return _buildLinkNotification(context);
      case NotificationType.generic:
        return _buildGenericNotification(context);

      default:
        return Container();
    }
  }

  Widget _buildPostLikeNotification(BuildContext context) {
    return ListTile(
      onTap: () {
        Posthog().capture(
          eventName: 'notification_opened',
          properties: {
            'notification_type': 'post_like',
            'notification_id': notification.id,
          },
        );

        BlocProvider.of<PostDetailBloc>(context).add(InitialEvent(
            post: notification.relatedPost, user: notification.relatedUser));

        BlocProvider.of<NavigationBloc>(context).add(OpenPostDetailScreen(
          postId: notification.relatedPost!.id,
        ));
      },
      tileColor: notification.seen
          ? App.appTheme.scaffoldBackgroundColor
          : Colors.grey[200],
      leading: GestureDetector(
        onTap: () {
          if (notification.relatedUserId == null) {
            return;
          }

          BlocProvider.of<UserDetailBloc>(context)
              .add(GetUser(userID: notification.relatedUserId!));
          BlocProvider.of<NavigationBloc>(context)
              .add(const OpenUserDetailScreen());
        },
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
                notification.relatedUser!.profilePicture),
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
          imageUrl: notification.relatedPost!.image,
          placeholder: (context, url) => const CardLoading(
            height: 80,
            width: 30,
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }

  Widget _buildPostCommentNotification(BuildContext context) {
    return ListTile(
      onTap: () {
        Posthog().capture(
          eventName: 'notification_opened',
          properties: {
            'notification_type': 'post_comment',
            'notification_id': notification.id,
          },
        );

        BlocProvider.of<PostDetailBloc>(context).add(InitialEvent(
            post: notification.relatedPost, user: notification.relatedUser));

        BlocProvider.of<NavigationBloc>(context).add(OpenPostDetailScreen(
          postId: notification.relatedPost!.id,
        ));
      },
      tileColor: notification.seen
          ? App.appTheme.scaffoldBackgroundColor
          : Colors.grey[200],
      leading: GestureDetector(
        onTap: () {
          BlocProvider.of<UserDetailBloc>(context)
              .add(GetUser(userID: notification.recipientId));
          BlocProvider.of<NavigationBloc>(context)
              .add(const OpenUserDetailScreen());
        },
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
                notification.relatedUser!.profilePicture),
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
          imageUrl: notification.relatedPost!.image,
          placeholder: (context, url) => const CardLoading(
            height: 80,
            width: 30,
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }

  Widget _buildPostHighlightNotification(BuildContext context) {
    return ListTile(
      onTap: () {
        Posthog().capture(
          eventName: 'notification_opened',
          properties: {
            'notification_type': 'post_highlight',
            'notification_id': notification.id,
          },
        );

        BlocProvider.of<PostDetailBloc>(context).add(InitialEvent(
            post: notification.relatedPost, user: notification.relatedUser));

        BlocProvider.of<NavigationBloc>(context).add(OpenPostDetailScreen(
          postId: notification.relatedPost!.id,
        ));
      },
      tileColor: notification.seen
          ? App.appTheme.scaffoldBackgroundColor
          : Colors.grey[200],
      leading: GestureDetector(
        onTap: () {},
        child: const Padding(
          padding: EdgeInsets.all(2),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: CachedNetworkImageProvider(
                "https://storage.googleapis.com/superkauf/logos/logo1.png"),
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
          imageUrl: notification.relatedPost!.image,
          placeholder: (context, url) => const CardLoading(
            height: 80,
            width: 30,
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }

  Widget _buildGenericNotification(BuildContext context) {
    return ListTile(
      onTap: () {
        Posthog().capture(
          eventName: 'notification_opened',
          properties: {
            'notification_type': 'generic',
            'notification_id': notification.id,
          },
        );
      },
      tileColor: notification.seen
          ? App.appTheme.scaffoldBackgroundColor
          : Colors.grey[200],
      leading: GestureDetector(
        onTap: () {},
        child: const Padding(
          padding: EdgeInsets.all(2),
          child: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
                "https://storage.googleapis.com/superkauf/logos/logo1.png"),
          ),
        ),
      ),
      title: Text(notification.text),
      subtitle: TimeAgoWidget(
        dateTime: notification.createdAt,
      ),
    );
  }

  Widget _buildLinkNotification(BuildContext context) {
    return ListTile(
      onTap: () async {
        Posthog().capture(
          eventName: 'notification_opened',
          properties: {
            'notification_type': 'link',
            'notification_id': notification.id,
          },
        );

        if (notification.url == null) {
          return;
        }
        final link = Uri.parse(notification.url!);
        if (!(await canLaunchUrl(link))) {
          return;
        }

        await launchUrl(link);
      },
      tileColor: notification.seen
          ? App.appTheme.scaffoldBackgroundColor
          : Colors.grey[200],
      leading: Padding(
        padding: const EdgeInsets.all(2),
        child: CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(notification.image == null
              ? "https://storage.googleapis.com/superkauf/logos/logo1.png"
              : notification.image!),
        ),
      ),
      title: Text(notification.text),
      subtitle: TimeAgoWidget(
        dateTime: notification.createdAt,
      ),
    );
  }
}
