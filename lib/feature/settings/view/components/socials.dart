import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:superkauf/generic/widget/app_button.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialsPanel extends StatelessWidget {
  const SocialsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 60,
          width: 60,
          child: Center(
            child: AppButton(
              onClick: () async {
                final url = Uri.parse('https://www.instagram.com/matyslav_');

                Posthog().capture(
                  eventName: 'my_instagram_button_clicked',
                  properties: {},
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
        ),
        const Gap(8),
        SizedBox(
          height: 60,
          width: 60,
          child: Center(
            child: AppButton(
              onClick: () async {
                final url = Uri.parse('https://discord.gg/rV7JRkPvJn');

                Posthog().capture(
                  eventName: 'my_discord_button_clicked',
                  properties: {},
                );
                await launchUrl(url);
              },
              elevation: 3.0,
              radius: 8.0,
              spaceTextImage: 0,
              backgroundColor: Colors.white,
              imageSuffix: const FaIcon(
                FontAwesomeIcons.discord,
                size: 24.0,
                color: Color(0xFF7289da),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
