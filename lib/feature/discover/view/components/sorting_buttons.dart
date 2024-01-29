import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/feature/discover/bloc/discover_bloc.dart';
import 'package:superkauf/generic/widget/app_button.dart';
import 'package:superkauf/library/app.dart';

class SortingButtons extends StatelessWidget {
  final SortType sortType;
  final TimeRange timeRange;

  const SortingButtons({
    super.key,
    required this.sortType,
    required this.timeRange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppButton(
          backgroundColor: App.appTheme.colorScheme.primary,
          text: sortType.name,
          radius: 8,
          textStyle: App.appTheme.textTheme.titleMedium!.copyWith(color: Colors.white),
          popupMenu: SortType.values.map((it) => PopupOption(value: it, title: it.name)).toList(),
          onSelectPopup: (value) {
            // context.read<DiscoverBloc>().add(
            //       ChangeSortType(sortType: value as SortType),
            //     );
          },
        ),
        const SizedBox(width: 8),
        AppButton(
          backgroundColor: App.appTheme.colorScheme.primary,
          radius: 8,
          textStyle: App.appTheme.textTheme.titleMedium!.copyWith(color: Colors.white),
          text: timeRange.name,
          popupMenu: TimeRange.values.map((it) => PopupOption(value: it, title: it.name)).toList(),
          onSelectPopup: (value) {
            context.read<DiscoverBloc>().add(
                  ChangeTimeRange(timeRange: value.value),
                );
          },
        ),
      ],
    );
  }
}
