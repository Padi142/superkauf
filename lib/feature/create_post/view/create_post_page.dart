import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superkauf/feature/create_post/bloc/create_post_bloc.dart';
import 'package:superkauf/feature/create_post/bloc/create_post_state.dart';
import 'package:superkauf/feature/create_post/view/components/store_card_picker.dart';
import 'package:superkauf/generic/constants.dart';
import 'package:superkauf/generic/store/model/store_model.dart';
import 'package:superkauf/generic/widget/app_button.dart';
import 'package:superkauf/generic/widget/app_progress.dart';
import 'package:superkauf/generic/widget/app_text_field/index.dart';
import 'package:superkauf/library/app.dart';

import '../../../library/app_screen.dart';
import 'components/store_picker.dart';

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
  StoreModel? selectedStore;
  var requiredCard = false;
  var createButtonClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: App.appTheme.colorScheme.background,
      appBar: AppBar(
        title: Text(
          'create_post_title'.tr(),
          style:
              App.appTheme.textTheme.titleMedium!.copyWith(color: Colors.white),
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
                  height: 40,
                ),
                SizedBox(
                  width: constraints.maxWidth * 0.75,
                  height: 300,
                  child: BlocBuilder<CreatePostBloc, CreatePostState>(
                      builder: (context, state) {
                    return state.maybeWhen(initial: () {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 220,
                            width: constraints.maxWidth * 0.30,
                            child: GestureDetector(
                              onTap: () {
                                BlocProvider.of<CreatePostBloc>(context)
                                    .add(const PickImage(isCamera: false));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(Icons.upload),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 220,
                            width: constraints.maxWidth * 0.30,
                            child: GestureDetector(
                              onTap: () {
                                BlocProvider.of<CreatePostBloc>(context)
                                    .add(const PickImage(isCamera: true));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(Icons.camera_alt_outlined),
                              ),
                            ),
                          ),
                        ],
                      );
                    }, imagePicked: (image) {
                      return GestureDetector(
                        onTap: () {
                          BlocProvider.of<CreatePostBloc>(context)
                              .add(const PickImage(isCamera: false));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.file(
                              image,
                              fit: BoxFit.fitHeight,
                            )),
                      );
                    }, loading: () {
                      return const AppProgress();
                    }, error: (error) {
                      return Text(
                        error,
                        style: App.appTheme.textTheme.bodyMedium,
                      );
                    }, orElse: () {
                      return const Center(child: AppProgress());
                    });
                  }),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: constraints.maxWidth * 0.85,
                  child: AppTextField(
                    descriptionField,
                    filled: App.appTheme.colorScheme.surface,
                    lines: 6,
                    hint: 'description_post_create_label'.tr(),
                    beginEdit: (te) {
                      te.model.error = null;
                      setState(() {});
                    },
                    validators: [
                      ValidatorEmpty(),
                      ValidatorRegex(r'^.{5,}$', 'Not enough characters'),
                      ValidatorRegex(r'^.{,250}$', 'Too many characters'),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StorePicker(
                      constraints: constraints,
                      onSelectStore: (store) {
                        selectedStore = store;
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.30,
                      child: AppTextField(
                        priceField,
                        filled: App.appTheme.colorScheme.surface,
                        keyboardType: TextInputType.number,
                        hint: 'price_post_create_label'.tr(),
                        beginEdit: (te) {
                          te.model.error = null;
                          setState(() {});
                        },
                        validators: [
                          ValidatorEmpty(),
                          ValidatorRegex(
                              r'^\d{1,5}(?:[.,]\d{1,2})?$', 'invalid number'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Text(
                      'card_required_label'.tr(),
                      style: App.appTheme.textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    StoreCardPicker(
                      onChange: (card) {
                        requiredCard = card;
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 50,
                  width: 270,
                  child: BlocBuilder<CreatePostBloc, CreatePostState>(
                      builder: (context, state) {
                    return state.maybeWhen(imagePicked: (image) {
                      return AppButton(
                        backgroundColor: App.appTheme.colorScheme.primary,
                        radius: 6,
                        text: 'button_post_create_label'.tr(),
                        textStyle: App.appTheme.textTheme.titleMedium!
                            .copyWith(color: Colors.white),
                        onClick: () async {
                          // Prevent multiple clicks
                          if (createButtonClicked) {
                            return;
                          }

                          // Prevent empty store
                          if (selectedStore == null) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('No store selected'),
                            ));
                            return;
                          }

                          //Validate fields
                          final valid = await TextEntryModel.validateFields(
                              [priceField, descriptionField]);
                          if (!valid) {
                            setState(() {});
                            return;
                          }

                          createButtonClicked = true;

                          BlocProvider.of<CreatePostBloc>(context)
                              .add(CreatePost(
                            description: descriptionField.text,
                            price: double.parse(
                                priceField.text.replaceAll(',', '.')),
                            store: selectedStore!,
                            cardRequired: requiredCard,
                            image: image,
                          ));
                        },
                      );
                    }, orElse: () {
                      return AppButton(
                        backgroundColor: Colors.grey,
                        radius: 6,
                        text: 'button_post_create_label'.tr(),
                        textStyle: App.appTheme.textTheme.titleMedium!
                            .copyWith(color: Colors.white),
                        onClick: () {},
                      );
                    });
                  }),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
