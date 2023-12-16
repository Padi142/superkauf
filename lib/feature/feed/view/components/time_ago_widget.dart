import 'package:flutter/material.dart';
import 'package:superkauf/library/app.dart';

class TimeAgoWidget extends StatelessWidget {
  final DateTime dateTime;

  const TimeAgoWidget({super.key, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Text(
      getTimeAgo(dateTime),
      style: App.appTheme.textTheme.bodySmall,
    );
  }

  String getTimeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);
    if (difference.inDays > 30) {
      return '${(difference.inDays / 30).round()} ${(difference.inDays / 30).floor() == 1 ? 'month' : 'month'} ago';
    } else if (difference.inDays > 7) {
      return '${(difference.inDays / 7).floor()} ${(difference.inDays / 7).floor() == 1 ? 'week' : 'weeks'} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'min' : 'mins'} ago';
    }
  }
}
