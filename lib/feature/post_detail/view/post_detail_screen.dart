import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/feature/post_detail/bloc/post_detail_bloc.dart';
import 'package:superkauf/feature/post_detail/bloc/post_detail_state.dart';
import 'package:superkauf/feature/post_detail/view/components/post_detail_description.dart';
import 'package:superkauf/feature/post_detail/view/components/post_detail_view_component.dart';
import 'package:superkauf/generic/constants.dart';
import 'package:superkauf/generic/post/bloc/post_bloc.dart';
import 'package:superkauf/generic/post/bloc/post_state.dart';
import 'package:superkauf/generic/widget/app_progress.dart';

import '../../../library/app_screen.dart';

class PostDetailScreen extends Screen {
  static const String name = ScreenPath.postDetailScreen;

  PostDetailScreen({Key? key}) : super(name, key: key);

  @override
  State<StatefulWidget> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: BlocListener<PostBloc, PostState>(
            listener: (context, state) {
              state.maybeMap(
                  error: (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(error.error),
                      ),
                    );
                  },
                  orElse: () {});
            },
            child: BlocBuilder<PostDetailBloc, PostDetailState>(
              builder: (context, state) {
                return state.maybeMap(initial: (initial) {
                  return SizedBox(
                      width: constraints.maxWidth,
                      child: Column(
                        children: [
                          PostDetailViewComponent(
                            constraints: constraints,
                            post: initial.post,
                            user: initial.user,
                            canEdit: false,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const AppProgress(),
                        ],
                      ));
                }, loaded: (loaded) {
                  return SizedBox(
                      width: constraints.maxWidth,
                      child: Column(
                        children: [
                          PostDetailViewComponent(
                            constraints: constraints,
                            post: loaded.post,
                            user: loaded.user,
                            canEdit: loaded.canEdit,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          PostDetailDescription(
                            constraints: constraints,
                            post: loaded.post,
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
          ),
        );
      }),
    );
  }
}
