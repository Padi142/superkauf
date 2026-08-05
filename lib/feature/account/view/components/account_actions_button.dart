import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:superkauf/feature/account/bloc/account_bloc.dart';
import 'package:superkauf/feature/home/bloc/navigation_bloc/navigation_bloc.dart';

class AccountActionsButton extends StatelessWidget {
  final Function() onChangeUsername;
  final Function() onChangeInstagram;
  const AccountActionsButton({
    super.key,
    required this.onChangeUsername,
    required this.onChangeInstagram,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(
        Icons.more_vert,
      ),
      // Icon for three dots
      onSelected: (String value) async {
        switch (value) {
          case 'deleteMyAccount':
            {
              BlocProvider.of<AccountBloc>(context).add(
                const LogOut(),
              );
              break;
            }
          case 'logout':
            {
              BlocProvider.of<AccountBloc>(context).add(
                const LogOut(),
              );
              break;
            }
          case 'settings':
            {
              BlocProvider.of<NavigationBloc>(context).add(
                const OpenSettingsScreen(shouldReplace: true),
              );
              break;
            }
          case 'changeUsername':
            {
              onChangeUsername();
            }

          case 'changeInstagram':
            {
              onChangeInstagram();
            }
          default:
            break;
        }
      },
      itemBuilder: (BuildContext context) {
        final List<PopupMenuItem<String>> list = [];

        list.add(PopupMenuItem<String>(
          value: 'changeUsername',
          child: Row(
            children: [
              const FaIcon(
                FontAwesomeIcons.pen,
                size: 20,
              ),
              const SizedBox(
                width: 8,
              ),
              Text('change_instagram_button_text'.tr()),
            ],
          ),
        ));

        list.add(PopupMenuItem<String>(
          value: 'changeInstagram',
          child: Row(
            children: [
              const FaIcon(
                FontAwesomeIcons.instagram,
                size: 20,
              ),
              const SizedBox(
                width: 8,
              ),
              Text('change_username_button_text'.tr()),
            ],
          ),
        ));

        list.add(PopupMenuItem<String>(
          value: 'deleteMyAccount',
          child: Row(
            children: [
              const Icon(
                Icons.delete_outline,
                color: Colors.red,
                size: 20,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                'delete_my_account_button_text'.tr(),
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
        ));

        list.add(PopupMenuItem<String>(
          value: 'logout',
          child: Row(
            children: [
              const Icon(
                Icons.logout,
                color: Colors.black,
                size: 20,
              ),
              const SizedBox(
                width: 8,
              ),
              Text('logout_button_text'.tr()),
            ],
          ),
        ));

        list.add(PopupMenuItem<String>(
          value: 'settings',
          child: Row(
            children: [
              const Icon(
                Icons.settings,
                color: Colors.black,
                size: 20,
              ),
              const SizedBox(
                width: 8,
              ),
              Text('settings_button_text'.tr()),
            ],
          ),
        ));

        return list;
      },
    );
  }
}
