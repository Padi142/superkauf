import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:superkauf/feature/account/bloc/account_bloc.dart';

class AccountActionsButton extends StatelessWidget {
  final Function() onChangeUsername;
  const AccountActionsButton({
    super.key,
    required this.onChangeUsername,
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
          case 'logout':
            {
              BlocProvider.of<AccountBloc>(context).add(
                const LogOut(),
              );
              break;
            }
          case 'changeUsername':
            {
              onChangeUsername();
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
              Text('change_username_button_text'.tr()),
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

        return list;
      },
    );
  }
}
