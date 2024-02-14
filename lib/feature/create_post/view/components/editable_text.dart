import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:superkauf/generic/widget/app_text_field/app_text_field.dart';
import 'package:superkauf/generic/widget/app_text_field/validator.dart';

class EditableTextField extends StatefulWidget {
  final String initialText;
  final TextEntryModel model;
  final TextStyle theme;
  final double? width;
  final TextInputType keyboardType;
  final List<Validator>? validators;
  final int maxLines;
  final Color filledColor;

  const EditableTextField({
    Key? key,
    required this.initialText,
    required this.model,
    required this.theme,
    required this.filledColor,
    this.validators,
    this.width,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  State<EditableTextField> createState() => _EditableTextFieldState();
}

class _EditableTextFieldState extends State<EditableTextField> {
  bool _isEditing = false;
  String text = '';

  @override
  void initState() {
    text = widget.initialText;

    super.initState();
    widget.model.focusNode.addListener(() {
      if (widget.model.focusNode.hasFocus && !_isEditing) {
        setState(() => _isEditing = true);
      } else if (!widget.model.focusNode.hasFocus && _isEditing) {
        setState(() => _isEditing = false);
      }
    });
  }

  @override
  void dispose() {
    widget.model.focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() => _isEditing = true);
        widget.model.focusNode.requestFocus();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: _isEditing ? widget.width ?? 60 : widget.width,
          // Adjust width as needed
          child: _isEditing
              ? AppTextField(
                  widget.model,
                  context: context,
                  autofocus: true,
                  filled: widget.filledColor,
                  border: const OutlineInputBorder(),
                  hint: widget.initialText,
                  keyboardType: widget.keyboardType,
                  validators: widget.validators ?? [],
                  lines: widget.maxLines,
                  beginEdit: (te) {
                    te.model.error = null;
                    setState(() {});
                  },
                  onChanged: (value) {
                    setState(() {
                      if (widget.model.controller.text.trim() == '') {
                        text = widget.initialText;
                      } else {
                        text = widget.model.controller.text;
                      }
                    });
                  },
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: widget.theme,
                    ),
                    if (widget.model.error != null)
                      Text(
                        widget.model.error!.tr(),
                        style: const TextStyle(color: Colors.red),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
