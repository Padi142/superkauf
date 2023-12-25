import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/feature/home/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:superkauf/feature/user_detail/bloc/user_detail_bloc.dart';
import 'package:superkauf/generic/user/model/user_model.dart';
import 'package:superkauf/generic/user/view/username_label.dart';

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
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<UserDetailBloc>(context)
                    .add(InitialUserEvent(user: user));
                BlocProvider.of<NavigationBloc>(context)
                    .add(const OpenUserDetailScreen());
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(user.profilePicture),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          UsernameLabel(user: user),
        ],
      ),
    );
  }
}
