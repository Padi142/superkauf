import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';

class LoadingFeedPost extends StatelessWidget {
  const LoadingFeedPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    child: CardLoading(
                      height: 40,
                      cardLoadingTheme: CardLoadingTheme(
                        colorOne: Theme.of(context).colorScheme.secondary,
                        colorTwo: Theme.of(context).colorScheme.primary,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                    ),
                  ),
                ),
                SizedBox(
                  width: constraints.maxWidth * 0.89,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 6),
                        child: Column(
                          children: [
                            CardLoading(
                              cardLoadingTheme: CardLoadingTheme(
                                colorOne: Theme.of(context).colorScheme.secondary,
                                colorTwo: Theme.of(context).colorScheme.primary,
                              ),
                              height: 270,
                              width: constraints.maxWidth,
                              borderRadius: const BorderRadius.all(Radius.circular(4)),
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: CardLoading(
                                        cardLoadingTheme: CardLoadingTheme(
                                          colorOne: Theme.of(context).colorScheme.secondary,
                                          colorTwo: Theme.of(context).colorScheme.primary,
                                        ),
                                        width: constraints.maxWidth * 0.79,
                                        height: 60,
                                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          })),
    );
  }
}

class PostLoadingView extends StatelessWidget {
  const PostLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        LoadingFeedPost(),
        LoadingFeedPost(),
      ],
    );
  }
}
