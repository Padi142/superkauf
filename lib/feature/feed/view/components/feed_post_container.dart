import 'package:flutter/material.dart';
import 'package:superkauf/feature/feed/view/components/time_ago_widget.dart';
import 'package:superkauf/generic/post/model/get_post_response.dart';
import 'package:superkauf/library/app.dart';

class FeedPostContainer extends StatelessWidget {
  final FeedPostModel post;

  const FeedPostContainer({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: LayoutBuilder(builder: (context, constraints) {
          return Card(
            child: Column(
              children: [
                Container(
                    width: constraints.maxWidth,
                    height: 50,
                    decoration: BoxDecoration(
                        color: App.appTheme.colorScheme.background),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(post.user.profilePicture),
                          ),
                        ),
                        Text(
                          post.user.name,
                          style: App.appTheme.textTheme.titleSmall,
                        ),
                        const Spacer(),
                        TimeAgoWidget(
                          dateTime: post.post.createdAt,
                        ),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    )),
                Container(
                  width: constraints.maxWidth,
                  height: 280,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(post.post.image),
                          fit: BoxFit.cover)),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: constraints.maxWidth * 0.9,
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
          );
        }));
  }
}
