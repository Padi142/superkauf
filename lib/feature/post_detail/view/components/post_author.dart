import 'package:flutter/material.dart';
import 'package:superkauf/generic/user/model/user_model.dart';
import 'package:superkauf/library/app.dart';

class PostAuthor extends StatelessWidget {
  final UserModel user;

  const PostAuthor({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(2),
            child: CircleAvatar(
              backgroundImage: NetworkImage(user.profilePicture),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            user.username,
            style: App.appTheme.textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
