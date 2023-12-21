import 'package:flutter/material.dart';
import 'package:superkauf/generic/user/model/user_model.dart';

class UserDetailViewPreview extends StatelessWidget {
  final BoxConstraints constraints;
  final UserModel user;

  const UserDetailViewPreview({super.key, required this.user, required this.constraints});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: constraints.maxWidth * 0.65,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 4.0),
            CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage(user.profilePicture),
            ),
            const SizedBox(height: 16.0),
            Text(
              user.username,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
