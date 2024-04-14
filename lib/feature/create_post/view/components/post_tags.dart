import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:superkauf/generic/widget/app_text_field/app_text_field.dart';
import 'package:superkauf/library/app.dart';

class PostTagsField extends StatefulWidget {
  final BoxConstraints constraints;
  final Function(List<String>) onTagsChanged;

  const PostTagsField({
    super.key,
    required this.constraints,
    required this.onTagsChanged,
  });

  @override
  State<PostTagsField> createState() => _PostTagsFieldState();
}

var tags = <String>[];

class _PostTagsFieldState extends State<PostTagsField> {
  final tagsModel = TextEntryModel();

  @override
  void initState() {
    tagsModel.controller.text = initialText;
    super.initState();
  }

  var initialText = " ";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Text(
            'tags_label'.tr(),
            style: App.appTheme.textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 8,
          ),
          AppTextField(
            tagsModel,
            context: context,
            hint: 'max. 3 tags',
            textInputAction: TextInputAction.go,
            filled: Theme.of(context).colorScheme.surface,
            onChanged: (text) {
              if (tagsModel.controller.text.length < initialText.length) {
                tagsModel.controller.text = initialText;
                tags.removeAt(tags.length - 1);
              }
            },
            prefixWidget: SizedBox(
              width: tags.length * widget.constraints.maxWidth * 0.3,
              child: Row(
                children: tags
                    .map((it) => Container(
                          color: App.appTheme.primaryColor,
                          padding: const EdgeInsets.all(6),
                          child: Text(
                            it,
                            style: App.appTheme.textTheme.titleSmall,
                          ),
                        ))
                    .toList(),
              ),
            ),
            onSubmit: (text) {
              if (text.trim().isEmpty || tags.contains(text)) {
                return;
              }
              tags.add(text);
              tagsModel.controller.text = initialText;
              widget.onTagsChanged(tags);
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
