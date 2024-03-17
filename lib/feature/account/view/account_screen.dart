import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_loading/card_loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:superkauf/feature/account/bloc/account_bloc.dart';
import 'package:superkauf/feature/account/bloc/account_state.dart';
import 'package:superkauf/feature/account/view/components/user_info.dart';
import 'package:superkauf/feature/home/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:superkauf/feature/post_detail/bloc/post_detail_bloc.dart';
import 'package:superkauf/generic/constants.dart';
import 'package:superkauf/generic/countries/bloc/countries_bloc.dart';
import 'package:superkauf/generic/widget/app_progress.dart';

import '../../../library/app_screen.dart';

class AccountScreen extends Screen {
  static const String name = ScreenPath.profileScreen;

  AccountScreen({Key? key}) : super(name, key: key);

  @override
  State<StatefulWidget> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<AccountScreen> {
  @override
  void initState() {
    BlocProvider.of<AccountBloc>(context).add(const GetUser());
    BlocProvider.of<CountriesBloc>(context).add(const GetCountries());

    super.initState();
  }

  var changeUsername = false;
  var changeInstagram = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('profile_page_title'.tr()),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          child: BlocBuilder<AccountBloc, AccountState>(
            builder: (context, state) {
              return state.maybeMap(loaded: (loaded) {
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: AccountInfoWidget(
                        user: loaded.user,
                        onUsernameChange: () {
                          setState(() {
                            changeUsername = !changeUsername;
                          });
                        },
                        onChangeInstagram: () {
                          setState(() {
                            changeInstagram = !changeInstagram;
                          });
                        },
                        onUsernameChaneDone: (String username) {
                          BlocProvider.of<AccountBloc>(context).add(ChangeUsername(
                            username: username,
                            user: loaded.user,
                          ));
                          setState(() {
                            changeUsername = false;
                          });
                        },
                        onInstagramChangeDone: (String instagram) {
                          BlocProvider.of<AccountBloc>(context).add(ChangeInstagram(
                            instagram: instagram,
                            user: loaded.user,
                          ));
                          setState(() {
                            changeInstagram = false;
                          });
                        },
                        changeUsername: changeUsername,
                        constraints: constraints,
                        changeInstagram: changeInstagram,
                      ),
                    ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    SliverGrid.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                      ),
                      itemCount: loaded.posts.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Hero(
                          tag: loaded.posts[index].post.id,
                          child: GestureDetector(
                            onTap: () {
                              BlocProvider.of<PostDetailBloc>(context).add(InitialEvent(
                                post: loaded.posts[index].post,
                                user: loaded.posts[index].user,
                              ));

                              BlocProvider.of<NavigationBloc>(context).add(OpenPostDetailScreen(
                                postId: loaded.posts[index].post.id,
                              ));
                            },
                            child: CachedNetworkImage(
                              imageUrl: loaded.posts[index].post.image,
                              imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                )),
                              ),
                              cacheManager: CacheManager(
                                Config(
                                  'post_image',
                                  stalePeriod: const Duration(days: 7),
                                ),
                              ),
                              progressIndicatorBuilder: (context, url, downloadProgress) => Center(child: CardLoading(height: constraints.maxWidth * 0.3)),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              }, error: (error) {
                // BlocProvider.of<SnackbarBloc>(context).add(ErrorSnackbar(message: error.error));
                return const AppProgress();
              }, orElse: () {
                return const AppProgress();
              });
            },
          ),
        );
      }),
    );
  }
}
