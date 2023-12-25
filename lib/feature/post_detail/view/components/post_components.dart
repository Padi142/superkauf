import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/feature/home/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:superkauf/library/app.dart';

class StoreLabel extends StatelessWidget {
  final String storeLabel;
  final int storeId;
  const StoreLabel({super.key, required this.storeLabel, required this.storeId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          BlocProvider.of<NavigationBloc>(context).add(OpenStoresScreen(null, storeId: storeId));
          Navigator.of(context).pop();
        },
        child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 4),
                  blurRadius: 4,
                  color: Colors.black.withOpacity(0.25),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(storeLabel,
                  style: App.appTheme.textTheme.titleMedium!.copyWith(
                    color: Colors.white,
                  )),
            )),
      ),
    );
  }
}

class CardRequired extends StatelessWidget {
  const CardRequired({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 4,
                color: Colors.black.withOpacity(0.25),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('post_store_card_required'.tr(),
                style: App.appTheme.textTheme.titleMedium!.copyWith(
                  color: Colors.white,
                )),
          )),
    );
  }
}
