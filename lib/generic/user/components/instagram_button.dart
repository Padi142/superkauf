import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:superkauf/feature/snackbar/bloc/snackbar_bloc.dart';
import 'package:superkauf/generic/user/model/user_model.dart';
import 'package:superkauf/generic/widget/app_button.dart';
import 'package:url_launcher/url_launcher.dart';

class InstagramButton extends StatelessWidget {
  final UserModel user;
  const InstagramButton({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 60,
      child: Center(
        child: AppButton(
          onClick: () async {
            if (user.instagram == '') {
              BlocProvider.of<SnackbarBloc>(context).add(const ErrorSnackbar(message: 'No Instagram account'));
              return;
            }
            final url = Uri.parse('https://www.instagram.com/${user.instagram}');

            Posthog().capture(
              eventName: 'instagram_button_clicked',
              properties: {
                'username': user.username,
                'instagram': user.instagram,
              },
            );
            await launchUrl(url);
          },
          elevation: 3.0,
          radius: 8.0,
          spaceTextImage: 0,
          backgroundColor: Colors.white,
          imageSuffix: const FaIcon(
            FontAwesomeIcons.instagram,
            size: 24.0,
            color: Colors.pink,
          ),
        ),
      ),
    );
  }
}
