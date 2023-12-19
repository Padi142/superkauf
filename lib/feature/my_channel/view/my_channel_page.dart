import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/feature/home/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:superkauf/generic/constants.dart';

import '../../../library/app_screen.dart';

class MyChannel extends Screen {
  static const String name = ScreenPath.myChannelScreen;

  MyChannel({Key? key}) : super(name, key: key);

  @override
  State<StatefulWidget> createState() => _MyChannelState();
}

class _MyChannelState extends State<MyChannel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<NavigationBloc>(context).add(const GoToCreatePostScreen());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
