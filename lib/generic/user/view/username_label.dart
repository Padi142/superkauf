import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:superkauf/feature/home/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:superkauf/feature/user_detail/bloc/user_detail_bloc.dart';
import 'package:superkauf/generic/user/model/user_model.dart';
import 'package:superkauf/library/app.dart';

class UsernameLabel extends StatelessWidget {
  final UserModel user;
  const UsernameLabel({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            BlocProvider.of<UserDetailBloc>(context)
                .add(InitialUserEvent(user: user));
            BlocProvider.of<NavigationBloc>(context)
                .add(const OpenUserDetailScreen());
          },
          child: Text(
            user.username,
            style: App.appTheme.textTheme.titleSmall,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        user.isAdmin
            ? const Tooltip(
                triggerMode: TooltipTriggerMode.tap,
                message: 'Krejzac.cz',
                child: FaIcon(
                  FontAwesomeIcons.shield,
                  color: Colors.amber,
                  size: 18,
                ),
              )
            : const SizedBox(),
        user.karma >= 100 && !user.isAdmin
            ? const Tooltip(
                triggerMode: TooltipTriggerMode.tap,
                message: 'This user has over 100 karma!',
                child: Icon(
                  Icons.verified,
                  color: Colors.blueAccent,
                  size: 18,
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
