import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:superkauf/feature/account/bloc/account_bloc.dart';
import 'package:superkauf/feature/account/view/components/account_actions_button.dart';
import 'package:superkauf/feature/account/view/components/change_username_component.dart';
import 'package:superkauf/generic/user/components/instagram_button.dart';
import 'package:superkauf/generic/user/model/user_model.dart';
import 'package:superkauf/library/app.dart';

class AccountInfoWidget extends StatelessWidget {
  final UserModel user;
  final Function() onUsernameChange;
  final Function() onChangeInstagram;
  final Function(String username) onUsernameChaneDone;
  final Function(String username) onInstagramChangeDone;
  final bool changeUsername;
  final bool changeInstagram;
  final BoxConstraints constraints;

  const AccountInfoWidget({
    super.key,
    required this.user,
    required this.onUsernameChange,
    required this.onChangeInstagram,
    required this.onInstagramChangeDone,
    required this.onUsernameChaneDone,
    required this.changeUsername,
    required this.changeInstagram,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: constraints.maxWidth * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 4.0),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage: NetworkImage(user.profilePicture),
                        ),
                      ),
                      Positioned(
                        top: 0.1,
                        right: 0.1,
                        child: IconButton(
                            onPressed: () {
                              BlocProvider.of<AccountBloc>(context).add(ChangeProfilePic(user: user));
                            },
                            icon: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: const FaIcon(
                                FontAwesomeIcons.cameraRetro,
                                color: Colors.black,
                                size: 24.0,
                              ),
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  changeUsername
                      ? ChangeUsernameField(
                          onDone: (username) {
                            onUsernameChaneDone(username);
                          },
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SelectableText(
                              user.username,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
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
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  SelectableText(
                    'Karma: ${user.karma}',
                    style: App.appTheme.textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  changeInstagram
                      ? ChangeInstagramField(
                          onDone: onInstagramChangeDone,
                        )
                      : InstagramButton(
                          user: user,
                        ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 2,
            top: 1,
            child: AccountActionsButton(
              onChangeUsername: () {
                onUsernameChange();
              },
              onChangeInstagram: () {
                onChangeInstagram();
              },
            ),
          ),
        ],
      ),
    );
  }
}
