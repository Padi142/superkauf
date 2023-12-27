import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/feature/user_detail/bloc/user_detail_bloc.dart';
import 'package:superkauf/feature/user_detail/bloc/user_detail_state.dart';
import 'package:superkauf/feature/user_detail/view/componenets/user_detail_view_preview.dart';
import 'package:superkauf/generic/constants.dart';
import 'package:superkauf/generic/widget/app_progress.dart';
import 'package:superkauf/library/app.dart';

import '../../../library/app_screen.dart';
import 'componenets/user_detail_view.dart';

class UserDetailScreen extends Screen {
  static const String name = ScreenPath.userDetailScreen;

  UserDetailScreen({Key? key}) : super(name, key: key);

  @override
  State<StatefulWidget> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: App.appTheme.colorScheme.background,
      appBar: AppBar(),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: BlocBuilder<UserDetailBloc, UserDetailState>(
            builder: (context, state) {
              return state.maybeMap(initial: (initial) {
                return SizedBox(
                    width: constraints.maxWidth,
                    child: Column(
                      children: [
                        UserDetailViewPreview(
                          user: initial.user,
                          constraints: constraints,
                        ),
                        const AppProgress()
                      ],
                    ));
              }, loaded: (loaded) {
                return SizedBox(
                    width: constraints.maxWidth,
                    child: Column(
                      children: [
                        UserDetailView(
                          user: loaded.user,
                          constraints: constraints,
                        ),
                      ],
                    ));
              }, error: (error) {
                return Text(error.error);
              }, orElse: () {
                return const Center(child: AppProgress());
              });
            },
          ),
        );
      }),
    );
  }
}
