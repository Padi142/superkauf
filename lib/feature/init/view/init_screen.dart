import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/generic/constants.dart';
import 'package:superkauf/library/app_scaffold.dart';

import '../../../generic/widget/app_progress.dart';
import '../../../library/app_screen.dart';
import '../bloc/init_bloc.dart';

class InitScreen extends Screen {
  static const String name = ScreenPath.initScreen;

  InitScreen({Key? key}) : super(name, key: key);

  @override
  State<StatefulWidget> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<InitBloc>(context).add(const InitApplication());
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      child: const AppScaffold(
        desktopLayout: MobileInitBody(),
        mobileLayout: MobileInitBody(),
      ),
    );
  }
}

class MobileInitBody extends StatelessWidget {
  const MobileInitBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 120,
        height: 120,
        child: AppProgress(),
      ),
    );
  }
}
