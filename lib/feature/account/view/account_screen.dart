import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:superkauf/feature/account/bloc/account_bloc.dart';
import 'package:superkauf/feature/account/bloc/account_state.dart';
import 'package:superkauf/generic/constants.dart';
import 'package:superkauf/generic/widget/app_progress.dart';
import 'package:superkauf/generic/widget/app_text_field/index.dart';
import 'package:superkauf/library/app.dart';

import '../../../library/app_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                  width: constraints.maxWidth * 0.65,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 4.0),
                                      CircleAvatar(
                                        radius: 50.0,
                                        backgroundImage: NetworkImage(loaded.user.profilePicture),
                                      ),
                                      const SizedBox(height: 16.0),
                                      Text(
                                        loaded.user.username,
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
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
                                        _showUsernamePopUp(context, loaded.user.id, (String username) {
                                          BlocProvider.of<AccountBloc>(context).add(ChangeUsername(username: username, id: loaded.user.id));
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
                    return Center(child: Text(error.error));
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

  void _showUsernamePopUp(BuildContext context, int userId, Function(String username) onDone) {
    final usernameModel = TextEntryModel(text: '');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          child: AlertDialog(
            title: const Text('Change username'),
            content: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 330,
                  child: AppTextField(
                    usernameModel,
                    filled: App.appTheme.colorScheme.surface,
                    hint: 'Username',
                    validators: [ValidatorEmpty(), ValidatorRegex(r'^[a-zA-Z0-9_]{3,}$', 'Username can only contain letters, numbers and underscores')],
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  final valid = await TextEntryModel.validateFields([usernameModel]);
                  if (!valid) {
                    setState(() {});
                    return;
                  }
                  if (valid) {
                    onDone(usernameModel.text);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }
}
