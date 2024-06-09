import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/feature/feed/view/components/post_icons.dart';
import 'package:superkauf/feature/feed/view/components/post_image.dart';
import 'package:superkauf/feature/feed/view/components/save_post_button.dart';
import 'package:superkauf/feature/feed/view/components/time_ago_widget.dart';
import 'package:superkauf/feature/home/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:superkauf/feature/home/bloc/saved_posts_panel_bloc/saved_posts_panel_bloc.dart';
import 'package:superkauf/feature/post_detail/bloc/post_detail_bloc.dart';
import 'package:superkauf/feature/user_detail/bloc/user_detail_bloc.dart';
import 'package:superkauf/generic/post/bloc/post_bloc.dart';
import 'package:superkauf/generic/post/model/get_post_response.dart';
import 'package:superkauf/generic/post/model/models/get_personal_post_response.dart';
import 'package:superkauf/generic/saved_posts/model/saved_post_model.dart';
import 'package:superkauf/generic/user/view/username_label.dart';
import 'package:superkauf/generic/widget/cdn_image.dart';

class FeedPostContainer extends StatefulWidget {
  final FeedPostModel post;
  final bool isPersonal;
  final String originScreen;

  const FeedPostContainer({
    super.key,
    required this.post,
    required this.isPersonal,
    required this.originScreen,
  });

  @override
  State<FeedPostContainer> createState() => _FeedPostContainerState();
}

class _FeedPostContainerState extends State<FeedPostContainer> {
  var reactions = 0;

  @override
  void initState() {
    super.initState();
    reactions = widget.post.post.likes;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 2, right: 8, bottom: 2),
      child: SizedBox(
          width: double.infinity,
          child: LayoutBuilder(builder: (context, constraints) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8.0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: constraints.maxWidth * 0.1,
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: GestureDetector(
                            onTap: () {
                              BlocProvider.of<UserDetailBloc>(context).add(
                                  InitialUserEvent(user: widget.post.user));
                              BlocProvider.of<UserDetailBloc>(context).add(
                                  GetUser(userID: widget.post.post.author));
                              BlocProvider.of<NavigationBloc>(context)
                                  .add(const OpenUserDetailScreen());
                            },
                            child: const Material(
                              elevation: 4,
                              shape: CircleBorder(),
                              child: CircleAvatar(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: constraints.maxWidth * 0.89,
                        child: Column(
                          children: [
                            SizedBox(
                              width: constraints.maxWidth * 0.89,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    UsernameLabel(user: widget.post.user),
                                    const Spacer(),
                                    TimeAgoWidget(
                                      dateTime: widget.post.post.createdAt,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                  ]),
                            ),
                            PostContent(
                              post: widget.post,
                              constraints: constraints,
                              originScreen: widget.originScreen,
                              savedPost: null,
                              addReaction: () {},
                              isSaved: false,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                reactions == 0
                    ? const SizedBox()
                    : Positioned(
                        bottom: 0,
                        right: 0,
                        child: HeartReaction(
                          reactions: reactions,
                          isClicked: false,
                        ),
                      ),
              ],
            );
          })),
    );
  }
}

enum LikedState { initial, liked, unliked }

class PersonalFeedPostContainer extends StatefulWidget {
  final FullContextPostModel post;
  final String originScreen;

  const PersonalFeedPostContainer({
    super.key,
    required this.post,
    required this.originScreen,
  });

  @override
  State<PersonalFeedPostContainer> createState() =>
      _PersonalFeedPostContainerState();
}

class _PersonalFeedPostContainerState extends State<PersonalFeedPostContainer> {
  var reactions = 0;
  var likeState = LikedState.initial;

  @override
  void initState() {
    super.initState();
    reactions = widget.post.post.likes;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 2, right: 8, bottom: 2),
      child: SizedBox(
          width: double.infinity,
          child: LayoutBuilder(builder: (context, constraints) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8.0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: constraints.maxWidth * 0.1,
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: GestureDetector(
                            onTap: () {
                              BlocProvider.of<UserDetailBloc>(context).add(
                                  GetUser(userID: widget.post.post.author));
                              BlocProvider.of<NavigationBloc>(context)
                                  .add(const OpenUserDetailScreen());
                            },
                            child: Material(
                                elevation: 4,
                                shape: const CircleBorder(),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(80), // Image border
                                  child: SizedBox.fromSize(
                                    size: const Size.fromRadius(
                                        16), // Image radius
                                    child: CdnImage(
                                      url: widget.post.user.profilePicture,
                                      constraints: const BoxConstraints(
                                          maxWidth: 40,
                                          maxHeight: 40,
                                          minWidth: 40,
                                          minHeight: 40),
                                      width: 150,
                                      height: 150,
                                    ),
                                  ),
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: constraints.maxWidth * 0.89,
                        child: Column(
                          children: [
                            SizedBox(
                              width: constraints.maxWidth * 0.89,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    UsernameLabel(user: widget.post.user),
                                    const Spacer(),
                                    TimeAgoWidget(
                                      dateTime: widget.post.post.createdAt,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                  ]),
                            ),
                            PostContent(
                              post: FeedPostModel(
                                post: widget.post.post,
                                user: widget.post.user,
                              ),
                              isSaved: widget.post.saved != null,
                              constraints: constraints,
                              savedPost: widget.post.saved,
                              originScreen: widget.originScreen,
                              addReaction: () {
                                if (likeState != LikedState.initial
                                    ? likeState == LikedState.liked
                                        ? true
                                        : false
                                    : widget.post.reaction != null) {
                                  BlocProvider.of<PostBloc>(context).add(
                                      RemoveReaction(
                                          postId: widget.post.post.id));
                                  setState(() {
                                    reactions--;
                                    likeState = LikedState.unliked;
                                  });
                                  return;
                                }
                                BlocProvider.of<PostBloc>(context).add(
                                    AddReaction(postId: widget.post.post.id));
                                setState(() {
                                  reactions++;
                                  likeState = LikedState.liked;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                reactions == 0
                    ? const SizedBox()
                    : Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            if (likeState != LikedState.initial
                                ? likeState == LikedState.liked
                                    ? true
                                    : false
                                : widget.post.reaction != null) {
                              BlocProvider.of<PostBloc>(context).add(
                                  RemoveReaction(postId: widget.post.post.id));
                              setState(() {
                                reactions--;
                                likeState = LikedState.unliked;
                              });
                              return;
                            }
                            BlocProvider.of<PostBloc>(context)
                                .add(AddReaction(postId: widget.post.post.id));
                            setState(() {
                              reactions++;
                              likeState = LikedState.liked;
                            });
                          },
                          child: HeartReaction(
                              reactions: reactions,
                              isClicked: likeState != LikedState.initial
                                  ? likeState == LikedState.liked
                                      ? true
                                      : false
                                  : widget.post.reaction != null),
                        ),
                      ),
              ],
            );
          })),
    );
  }
}

class PostContent extends StatelessWidget {
  final FeedPostModel post;
  final BoxConstraints constraints;
  final String originScreen;
  final SavedPostModel? savedPost;
  final Function() addReaction;
  final bool isSaved;

  const PostContent({
    super.key,
    required this.post,
    required this.constraints,
    required this.originScreen,
    required this.savedPost,
    required this.addReaction,
    required this.isSaved,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        addReaction();
      },
      onTap: () {
        BlocProvider.of<PostDetailBloc>(context)
            .add(InitialEvent(post: post.post, user: post.user));
        BlocProvider.of<NavigationBloc>(context).add(OpenPostDetailScreen(
          postId: post.post.id,
        ));
      },
      child: Card(
        elevation: 7,
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 6),
          child: Column(
            children: [
              SizedBox(
                height: 280,
                child: Stack(
                  children: [
                    FeedPostImage(
                      postImage: post.post.image,
                      id: post.post.id,
                      constraints: constraints,
                    ),
                    Positioned(
                      right: 2,
                      top: 4,
                      child: Row(
                        children: [
                          StoreNameIcon(
                            storeName: post.post.storeName,
                          ),
                          post.post.requiresStoreCard
                              ? const RequiresStoreCard()
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 2,
                      bottom: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SavePostButton(
                            post: post.post,
                            isSaved: isSaved || savedPost != null,
                            onPressed: (value) {
                              if (value) {
                                BlocProvider.of<PostBloc>(context).add(
                                  SavePost(
                                    postId: post.post.id,
                                  ),
                                );
                                BlocProvider.of<SavedPostsPanelBloc>(context)
                                    .add(OpenSavedPostsPanel(
                                  storeId: post.post.store,
                                  postId: post.post.id,
                                ));
                              } else {
                                BlocProvider.of<PostBloc>(context).add(
                                  RemoveSavedPost(
                                    postId: post.post.id,
                                  ),
                                );
                              }
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Hero(
                            tag: 'price${post.post.id}',
                            child: FeedContainerPrice(
                              price: post.post.price,
                            ),
                          ),
                        ],
                      ),
                    ),
                    post.post.validUntil != null
                        ? Positioned(
                            top: 1,
                            left: 1,
                            child: FeedPostValidUntilLabel(
                              validUntil: post.post.validUntil!,
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: SizedBox(
                          width: constraints.maxWidth * 0.79,
                          child: Text(
                            post.post.description,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class FeedPostContainer extends StatelessWidget {
//   final FeedPostModel post;
//
//   const FeedPostContainer({super.key, required this.post});
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         width: double.infinity,
//         child: LayoutBuilder(builder: (context, constraints) {
//           return Card(
//             child: Column(
//               children: [
//                 Container(
//                     width: constraints.maxWidth,
//                     height: 50,
//                     decoration: BoxDecoration(color: App.appTheme.colorScheme.background),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8),
//                           child: CircleAvatar(
//                             backgroundImage: NetworkImage(post.user.profilePicture),
//                           ),
//                         ),
//                         Text(
//                           post.user.name,
//                           style: Theme.of(context).textTheme.titleSmall,
//                         ),
//                         const Spacer(),
//                         TimeAgoWidget(
//                           dateTime: post.post.createdAt,
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         )
//                       ],
//                     )),
//                 Container(
//                   width: constraints.maxWidth,
//                   height: 280,
//                   decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(post.post.image), fit: BoxFit.cover)),
//                 ),
//                 Column(
//                   children: [
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: SizedBox(
//                             width: constraints.maxWidth * 0.9,
//                             child: Text(
//                               post.post.description,
//                               style: Theme.of(context).textTheme.bodyMedium,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         }));
//   }
// }
