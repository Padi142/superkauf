import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/feature/feed/view/components/time_ago_widget.dart';
import 'package:superkauf/feature/home/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:superkauf/feature/post_detail/bloc/post_detail_bloc.dart';
import 'package:superkauf/feature/user_detail/bloc/user_detail_bloc.dart';
import 'package:superkauf/generic/post/model/get_post_response.dart';
import 'package:superkauf/generic/widget/app_progress.dart';
import 'package:superkauf/library/app.dart';

class FeedPostContainer extends StatelessWidget {
  final FeedPostModel post;

  const FeedPostContainer({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {},
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 2, right: 2, bottom: 2),
        child: SizedBox(
            width: double.infinity,
            child: LayoutBuilder(builder: (context, constraints) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: constraints.maxWidth * 0.1,
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: GestureDetector(
                        onTap: () {
                          BlocProvider.of<UserDetailBloc>(context).add(GetUser(userID: post.post.author));
                          BlocProvider.of<NavigationBloc>(context).add(const OpenUserDetailScreen());
                        },
                        child: Material(
                          elevation: 6,
                          shape: const CircleBorder(),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(post.user.profilePicture),
                          ),
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
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.end, children: [
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                BlocProvider.of<UserDetailBloc>(context).add(InitialUserEvent(user: post.user));
                                BlocProvider.of<NavigationBloc>(context).add(const OpenUserDetailScreen());
                              },
                              child: Text(
                                post.user.username,
                                style: App.appTheme.textTheme.titleSmall,
                              ),
                            ),
                            const Spacer(),
                            TimeAgoWidget(
                              dateTime: post.post.createdAt,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                          ]),
                        ),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<PostDetailBloc>(context).add(InitialEvent(post: post.post, user: post.user));
                            BlocProvider.of<NavigationBloc>(context).add(const OpenPostDetailScreen());
                          },
                          child: Card(
                            elevation: 7,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 6),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 280,
                                    child: Stack(
                                      children: [
                                        SizedBox(
                                          width: constraints.maxWidth,
                                          child: Hero(
                                            tag: post.post.id,
                                            child: CachedNetworkImage(
                                              imageUrl: post.post.image,
                                              imageBuilder: (context, imageProvider) => Container(
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                )),
                                              ),
                                              placeholder: (context, url) => const Center(child: AppProgress()),
                                              errorWidget: (context, url, error) => const Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 2,
                                          top: 4,
                                          child: Card(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(16.0),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(6),
                                              child: Text(
                                                post.post.storeName,
                                                style: App.appTheme.textTheme.bodyMedium,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 2,
                                          bottom: 4,
                                          child: Hero(
                                            tag: 'price${post.post.id}',
                                            child: Card(
                                              elevation: 10,
                                              color: Colors.yellowAccent,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(16.0),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Text(
                                                  '${post.post.price} Kč',
                                                  style: App.appTheme.textTheme.titleLarge,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
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
                                                style: App.appTheme.textTheme.bodyMedium,
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
                        ),
                      ],
                    ),
                  ),
                ],
              );
            })),
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
//                           style: App.appTheme.textTheme.titleSmall,
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
//                               style: App.appTheme.textTheme.bodyMedium,
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
