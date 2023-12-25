import 'package:flutter/material.dart';
import 'package:superkauf/library/app.dart';

import '../../../../generic/widget/app_text_field/index.dart';

class ChangeUsernameField extends StatefulWidget {
  final Function(String) onDone;

  const ChangeUsernameField({super.key, required this.onDone});

  @override
  State<ChangeUsernameField> createState() => _ChangeUsernameFieldState();
}

final usernameModel = TextEntryModel(text: '');

class _ChangeUsernameFieldState extends State<ChangeUsernameField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 180,
          child: AppTextField(
            usernameModel,
            filled: App.appTheme.colorScheme.surface,
            hint: 'Username',
            autofocus: true,
            validators: [ValidatorEmpty(), ValidatorRegex(r'^[a-zA-Z0-9_]{3,15}$', 'Invalid username (3-15 characters')],
          ),
        ),
        const SizedBox(
          width: 2,
        ),
        IconButton(
          onPressed: () async {
            usernameModel.controller.text.trim();
            final valid = await TextEntryModel.validateFields([usernameModel]);
            if (!valid) {
              setState(() {});
              return;
            }
            if (valid) {
              widget.onDone(usernameModel.text);
            }
          },
          icon: const Icon(Icons.check),
        ),
      ],
    );
  }
}
