import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:superkauf/generic/post/model/post_model.dart';
import 'package:superkauf/generic/widget/app_text_field/index.dart';

class EditDescriptionField extends StatefulWidget {
  final PostModel post;
  final Function(String newDescription) onDone;

  const EditDescriptionField({
    super.key,
    required this.post,
    required this.onDone,
  });

  @override
  State<EditDescriptionField> createState() => _EditDescriptionFieldState();
}

class _EditDescriptionFieldState extends State<EditDescriptionField> {
  final postModel = TextEntryModel();

  @override
  void initState() {
    postModel.controller.text = widget.post.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: constraints.maxWidth * 0.8,
            child: AppTextField(
              postModel,
              context: context,
              filled: Theme.of(context).colorScheme.surface,
              lines: 10,
              autofocus: true,
              hint: 'description_post_create_label'.tr(),
              beginEdit: (te) {
                te.model.error = null;
                setState(() {});
              },
              validators: [ValidatorEmpty(), ValidatorRegex(r'^.{5,250}$', 'Post can be 5-250 chars long')],
            ),
          ),
          const SizedBox(
            width: 2,
          ),
          IconButton(
            onPressed: () async {
              postModel.controller.text.trim();
              final valid = await TextEntryModel.validateFields([postModel]);
              if (!valid) {
                setState(() {});
                return;
              }
              if (valid) {
                widget.onDone(postModel.text);
              }
            },
            icon: const Icon(Icons.check),
          ),
        ],
      );
    });
  }
}
