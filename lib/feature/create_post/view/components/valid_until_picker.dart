import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:superkauf/generic/functions.dart';
import 'package:superkauf/generic/widget/app_button.dart';
import 'package:superkauf/library/app.dart';

class ValidUntilPicker extends StatefulWidget {
  final BoxConstraints constraints;

  final Function(DateTime validUntil) validUntilPicked;

  const ValidUntilPicker({super.key, required this.validUntilPicked, required this.constraints});

  @override
  State<ValidUntilPicker> createState() => _ValidUntilPickerState();
}

DateTime? validUntil;

class _ValidUntilPickerState extends State<ValidUntilPicker> {
  @override
  void initState() {
    validUntil = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Text(
            'sale_ends_in_label'.tr(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Spacer(),
          SizedBox(
            width: widget.constraints.maxWidth * 0.30,
            child: AppButton(
                borderColor: App.appTheme.colorScheme.primary,
                radius: 8,
                onClick: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (picked != null) {
                    setState(() {
                      validUntil = picked;
                    });
                    widget.validUntilPicked(picked);
                  }
                },
                text: validUntil == null ? 'sale_ends_in_not_picked_label'.tr() : getDaysUntilString(validUntil!)),
          ),
        ],
      ),
    );
  }
}
