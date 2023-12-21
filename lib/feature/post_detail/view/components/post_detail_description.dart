import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/feature/home/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:superkauf/generic/post/model/post_model.dart';
import 'package:superkauf/library/app.dart';

class PostDetailDescription extends StatelessWidget {
  final BoxConstraints constraints;
  final PostModel post;

  const PostDetailDescription({super.key, required this.constraints, required this.post});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: constraints.maxWidth * 0.95,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: SelectableText(
                post.description,
                style: App.appTheme.textTheme.bodyLarge,
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Text('post_tags_label'.tr(), style: App.appTheme.textTheme.titleSmall),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<NavigationBloc>(context).add(OpenStoresScreen(null, storeId: post.store));
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 4),
                              blurRadius: 4,
                              color: Colors.black.withOpacity(0.25),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(post.storeName,
                              style: App.appTheme.textTheme.titleMedium!.copyWith(
                                color: Colors.white,
                              )),
                        )),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
