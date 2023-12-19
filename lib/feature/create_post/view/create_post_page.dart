import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/feature/create_post/bloc/create_post_bloc.dart';
import 'package:superkauf/feature/create_post/bloc/create_post_state.dart';
import 'package:superkauf/generic/constants.dart';
import 'package:superkauf/generic/widget/app_button.dart';
import 'package:superkauf/generic/widget/app_progress.dart';
import 'package:superkauf/generic/widget/app_text_field/index.dart';
import 'package:superkauf/library/app.dart';

import '../../../library/app_screen.dart';

class CreatePostScreen extends Screen {
  static const String name = ScreenPath.createPostScreen;

  CreatePostScreen({Key? key}) : super(name, key: key);

  @override
  State<StatefulWidget> createState() => _CreatePostScreen();
}

class _CreatePostScreen extends State<CreatePostScreen> {
  @override
  void initState() {
    BlocProvider.of<CreatePostBloc>(context).add(const InitialEvent());
    super.initState();
  }

  final TextEntryModel descriptionField = TextEntryModel();
  final TextEntryModel priceField = TextEntryModel();
  var selectedStore = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'create_post_title'.tr(),
          style: App.appTheme.textTheme.titleMedium,
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: SizedBox(
            width: constraints.maxWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 80,
                ),
                SizedBox(
                  width: constraints.maxWidth * 0.75,
                  height: 220,
                  child: BlocBuilder<CreatePostBloc, CreatePostState>(builder: (context, state) {
                    return state.maybeWhen(initial: () {
                      return GestureDetector(
                        onTap: () {
                          BlocProvider.of<CreatePostBloc>(context).add(const UploadImage());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.upload),
                        ),
                      );
                    }, imageUploaded: (image) {
                      return GestureDetector(
                        onTap: () {
                          BlocProvider.of<CreatePostBloc>(context).add(const UploadImage());
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.network(
                              image,
                              fit: BoxFit.cover,
                            )),
                      );
                    }, error: (error) {
                      return Text(
                        error,
                        style: App.appTheme.textTheme.bodyMedium,
                      );
                    }, orElse: () {
                      return const AppProgress();
                    });
                  }),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: 330,
                  child: AppTextField(
                    descriptionField,
                    filled: App.appTheme.colorScheme.surface,
                    hint: 'description_post_create_label'.tr(),
                    validators: [ValidatorEmpty()],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: constraints.maxWidth * 0.70,
                  child: Row(
                    children: [
                      SizedBox(
                        width: constraints.maxWidth * 0.30,
                        child: AppButton(
                          text: 'store_post_create_label'.tr(),
                          popupMenu: [
                            PopupOption(
                              title: 'Albert',
                              value: 'Albert',
                            ),
                            PopupOption(
                              title: 'Lidl',
                              value: 'Lidl',
                            ),
                            PopupOption(
                              title: 'Kaufland',
                              value: 'Kaufland',
                            ),
                            PopupOption(
                              title: 'Billa',
                              value: 'Billa',
                            ),
                            PopupOption(
                              title: 'Zabka',
                              value: 'Zabka',
                            ),
                          ],
                          onSelectPopup: (value) {
                            selectedStore = value.value;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: constraints.maxWidth * 0.30,
                        child: AppTextField(
                          priceField,
                          filled: App.appTheme.colorScheme.surface,
                          hint: 'price_post_create_label'.tr(),
                          validators: [ValidatorEmpty()],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                SizedBox(
                  height: 50,
                  width: 270,
                  child: BlocBuilder<CreatePostBloc, CreatePostState>(builder: (context, state) {
                    return state.maybeWhen(imageUploaded: (image) {
                      return AppButton(
                        backgroundColor: App.appTheme.colorScheme.primary,
                        radius: 6,
                        text: 'button_post_create_label'.tr(),
                        textStyle: App.appTheme.textTheme.titleMedium!.copyWith(color: Colors.white),
                        onClick: () {
                          if (selectedStore == '') {
                            return;
                          }
                          BlocProvider.of<CreatePostBloc>(context).add(CreatePost(
                            description: descriptionField.text,
                            price: double.parse(priceField.text),
                            storeName: selectedStore,
                            image: image,
                          ));
                        },
                      );
                    }, orElse: () {
                      return AppButton(
                        backgroundColor: App.appTheme.colorScheme.surface,
                        radius: 6,
                        text: 'button_post_create_label'.tr(),
                        textStyle: App.appTheme.textTheme.titleMedium!.copyWith(color: Colors.white),
                        onClick: () {},
                      );
                    });
                  }),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
