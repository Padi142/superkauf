import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/feature/feed/bloc/feed_bloc.dart';
import 'package:superkauf/feature/feed/bloc/feed_state.dart';
import 'package:superkauf/feature/feed/view/components/feed_post_container.dart';
import 'package:superkauf/generic/constants.dart';
import 'package:superkauf/generic/widget/app_progress.dart';

import '../../../library/app_screen.dart';

class FeedScreen extends Screen {
  static const String name = ScreenPath.feedScreen;

  FeedScreen({Key? key}) : super(name, key: key);

  @override
  State<StatefulWidget> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  void initState() {
    BlocProvider.of<FeedBloc>(context).add(const GetFeed());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          BlocBuilder<FeedBloc, FeedState>(
            builder: (context, state) {
              return state.maybeMap(loaded: (loaded) {
                return SizedBox(
                  height: constraints.maxHeight,
                  child: ListView.builder(
                    itemCount: loaded.posts.length,
                    itemBuilder: (context, index) {
                      return FeedPostContainer(post: loaded.posts[index]);
                    },
                  ),
                );
              }, error: (error) {
                return Center(child: Text(error.error));
              }, orElse: () {
                return const Center(child: AppProgress());
              });
            },
          ),
        ],
      );
    });
  }
}
