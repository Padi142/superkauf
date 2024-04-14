import 'package:flutter/material.dart';

import '../../../../generic/widget/app_text_field/index.dart';

class ChangeUsernameField extends StatefulWidget {
  final Function(String) onDone;

  const ChangeUsernameField({super.key, required this.onDone});

  @override
  State<ChangeUsernameField> createState() => _ChangeUsernameFieldState();
}

class _ChangeUsernameFieldState extends State<ChangeUsernameField> {
  final usernameModel = TextEntryModel(text: '');

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 180,
          child: AppTextField(
            usernameModel,
            context: context,
            filled: Theme.of(context).colorScheme.surface,
            hint: 'Username',
            autofocus: true,
            validators: [ValidatorEmpty(), ValidatorRegex(r'^[a-zA-Z0-9_!@#$%^&*()\-+=.]{3,30}', 'Invalid username (3-30 characters')],
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

class ChangeInstagramField extends StatefulWidget {
  final Function(String) onDone;

  const ChangeInstagramField({super.key, required this.onDone});

  @override
  State<ChangeInstagramField> createState() => _ChangeInstagramFieldState();
}

final instagramEntry = TextEntryModel(text: '');

class _ChangeInstagramFieldState extends State<ChangeInstagramField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 180,
          child: AppTextField(
            instagramEntry,
            context: context,
            filled: Theme.of(context).colorScheme.surface,
            hint: 'ig username',
            autofocus: true,
            validators: [ValidatorEmpty(), ValidatorRegex(r'^[a-zA-Z0-9._]{1,30}$', 'Invalid username (3-30 characters')],
          ),
        ),
        const SizedBox(
          width: 2,
        ),
        IconButton(
          onPressed: () async {
            instagramEntry.controller.text.trim();
            final valid = await TextEntryModel.validateFields([instagramEntry]);
            if (!valid) {
              setState(() {});
              return;
            }
            if (valid) {
              widget.onDone(instagramEntry.text);
            }
          },
          icon: const Icon(Icons.check),
        ),
      ],
    );
  }
}
