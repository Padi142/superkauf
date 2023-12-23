import 'package:flutter/material.dart';
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
    return SizedBox(
      width: 150,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: App.appTheme.colorScheme.primary),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppButton(
                backgroundColor: cardRequired ? App.appTheme.colorScheme.surface : App.appTheme.colorScheme.primary,
                text: 'No',
                textStyle: App.appTheme.textTheme.titleMedium,
                radius: 8,
                onClick: () {
                  setState(() {
                    cardRequired = false;
                  });
                  widget.onChange(false);
                }),
            const SizedBox(
              width: 5,
            ),
            AppButton(
                backgroundColor: cardRequired ? App.appTheme.colorScheme.primary : App.appTheme.colorScheme.surface,
                text: 'Yes',
                textStyle: App.appTheme.textTheme.titleMedium,
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
    );
  }
}
