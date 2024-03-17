import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/feature/search/bloc/search_bloc.dart';
import 'package:superkauf/feature/search/bloc/search_state.dart';
import 'package:superkauf/feature/search/view/components/search_post_container.dart';
import 'package:superkauf/generic/constants.dart';
import 'package:superkauf/generic/widget/app_text_field/app_text_field.dart';
import 'package:superkauf/library/app.dart';

import '../../../library/app_screen.dart';

class SearchScreen extends Screen {
  static const String name = ScreenPath.searchScreen;

  SearchScreen({Key? key}) : super(name, key: key);

  @override
  State<StatefulWidget> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<SearchScreen> {
  final ScrollController _scrollController = ScrollController();
  final model = TextEntryModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return CustomScrollView(controller: _scrollController, slivers: [
        SliverPersistentHeader(
          pinned: false,
          floating: true,
          delegate: _AppBarDelegate(
            minHeight: 80,
            maxHeight: 80,
            child: SizedBox(
              width: constraints.maxWidth,
              height: 80,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppTextField(
                  model,
                  hint: 'search_page_placeholder'.tr(),
                  filled: App.appTheme.scaffoldBackgroundColor,
                  autofocus: true,
                  suffixWidget: const Icon(Icons.search),
                  radius: 20,
                  onChanged: (value) {
                    EasyDebounce.debounce('search-debouncer', const Duration(milliseconds: 300), () {
                      context.read<SearchBloc>().add(SearchPosts(input: value));
                    });
                  },
                  context: context,
                ),
              ),
            ),
          ),
        ),
        BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
          return state.maybeMap(loaded: (loaded) {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: loaded.posts.length,
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SearchPostContainer(
                      post: loaded.posts[index],
                      constraints: constraints,
                    ),
                  );
                },
              ),
            );
            ;
          }, initial: (_) {
            return SliverToBoxAdapter(child: Center(child: Text('search_page_label'.tr())));
          }, orElse: () {
            return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
          });
        })
      ]);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class _AppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _AppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
