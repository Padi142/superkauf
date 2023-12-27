import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:superkauf/feature/account/bloc/account_bloc.dart';
import 'package:superkauf/feature/account/bloc/account_state.dart';
import 'package:superkauf/feature/snackbar/bloc/snackbar_bloc.dart';
import 'package:superkauf/generic/constants.dart';
import 'package:superkauf/generic/widget/app_progress.dart';
import 'package:superkauf/library/app.dart';

import '../../../library/app_screen.dart';
import 'components/change_username_component.dart';

class AccountScreen extends Screen {
  static const String name = ScreenPath.profileScreen;

  AccountScreen({Key? key}) : super(name, key: key);

  @override
  State<StatefulWidget> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<AccountScreen> {
  @override
  void initState() {
    BlocProvider.of<AccountBloc>(context).add(const GetUser());
    super.initState();
  }

  var changeUsername = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: App.appTheme.colorScheme.background,
      appBar: AppBar(
        title: Text('profile_page_title'.tr()),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          child: Column(
            children: [
              BlocBuilder<AccountBloc, AccountState>(
                builder: (context, state) {
                  return state.maybeMap(loaded: (loaded) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
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
                                              backgroundImage: NetworkImage(loaded.user.profilePicture),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0.1,
                                            right: 0.1,
                                            child: IconButton(
                                                onPressed: () {
                                                  BlocProvider.of<AccountBloc>(context).add(ChangeProfilePic(user: loaded.user));
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
                                                BlocProvider.of<AccountBloc>(context).add(ChangeUsername(
                                                  username: username,
                                                  user: loaded.user,
                                                ));
                                                setState(() {
                                                  changeUsername = false;
                                                });
                                              },
                                            )
                                          : Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  loaded.user.username,
                                                  style: const TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                loaded.user.isAdmin
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
                                                loaded.user.karma >= 100 && !loaded.user.isAdmin
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
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                  right: 2,
                                  top: 1,
                                  child: IconButton(
                                      iconSize: 16.0,
                                      onPressed: () {
                                        setState(() {
                                          changeUsername = !changeUsername;
                                        });
                                      },
                                      icon: const FaIcon(FontAwesomeIcons.pen))),
                            ],
                          ),
                        ),
                        const SizedBox(height: 50.0),
                        ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<AccountBloc>(context).add(
                              const LogOut(),
                            );
                          },
                          child: Text('logout_button_text'.tr()),
                        ),
                      ],
                    );
                  }, error: (error) {
                    BlocProvider.of<SnackbarBloc>(context).add(ErrorSnackbar(message: error.error));
                    return const AppProgress();
                  }, orElse: () {
                    return const AppProgress();
                  });
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
