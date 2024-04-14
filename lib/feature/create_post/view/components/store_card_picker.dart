import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:superkauf/generic/widget/app_button.dart';
import 'package:superkauf/library/app.dart';

class StoreCardPicker extends StatefulWidget {
  final Function(bool) onChange;

  const StoreCardPicker({super.key, required this.onChange});

  @override
  State<StoreCardPicker> createState() => _StoreCardPickerState();
}

class _StoreCardPickerState extends State<StoreCardPicker> {
  var cardRequired = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'card_required_label'.tr(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: App.appTheme.colorScheme.primary),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppButton(
                      backgroundColor: cardRequired ? Theme.of(context).colorScheme.surface : Theme.of(context).colorScheme.primary,
                      text: 'No',
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                      radius: 8,
                      onClick: () {
                        setState(() {
                          cardRequired = false;
                        });
                        widget.onChange(false);
                        Posthog().capture(eventName: 'create_post_store_picked');
                      }),
                  const SizedBox(
                    width: 5,
                  ),
                  AppButton(
                      backgroundColor: cardRequired ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surface,
                      text: 'Yes',
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                      radius: 8,
                      onClick: () {
                        setState(() {
                          cardRequired = true;
                        });
                        widget.onChange(true);
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
