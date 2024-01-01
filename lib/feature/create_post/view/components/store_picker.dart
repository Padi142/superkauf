import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/generic/store/bloc/store_bloc.dart';
import 'package:superkauf/generic/store/bloc/store_state.dart';
import 'package:superkauf/generic/store/model/store_model.dart';
import 'package:superkauf/generic/widget/app_button.dart';
import 'package:superkauf/library/app.dart';

class StorePicker extends StatefulWidget {
  final BoxConstraints constraints;
  final Function(StoreModel store) onSelectStore;

  const StorePicker({
    super.key,
    required this.constraints,
    required this.onSelectStore,
  });

  @override
  State<StorePicker> createState() => _StorePickerState();
}

class _StorePickerState extends State<StorePicker> {
  @override
  void initState() {
    BlocProvider.of<StoreBloc>(context).add(const GetAllStores());
    super.initState();
  }

  var label = '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.constraints.maxWidth * 0.30,
      child: BlocBuilder<StoreBloc, StoreState>(builder: (context, state) {
        return state.maybeMap(success: (success) {
          return AppButton(
            text: label == '' ? 'store_post_create_label'.tr() : label,
            borderColor: App.appTheme.colorScheme.primary,
            radius: 8,
            imagePrefix: label == ''
                ? const SizedBox()
                : SizedBox(
                    width: 40,
                    height: 30,
                    child: Image.network(
                      success.stores.firstWhere((element) => element.name == label).image,
                    ),
                  ),
            popupMenu: success.stores
                .map((element) => PopupOption(
                      title: element.name,
                      value: element,
                    ))
                .toList(),
            onSelectPopup: (value) {
              widget.onSelectStore(value.value);
              label = value.title;
              setState(() {});
            },
          );
        }, orElse: () {
          return const SizedBox();
        });
      }),
    );
  }
}
