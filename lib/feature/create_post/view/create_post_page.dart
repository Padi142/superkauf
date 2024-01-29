import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:superkauf/feature/create_post/bloc/create_post_bloc.dart';
import 'package:superkauf/feature/create_post/bloc/create_post_state.dart';
import 'package:superkauf/feature/create_post/view/components/store_card_picker.dart';
import 'package:superkauf/feature/create_post/view/components/valid_until_picker.dart';
import 'package:superkauf/feature/snackbar/bloc/snackbar_bloc.dart';
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
    _imagePickPanelController = PanelController();
    super.initState();
  }

  final TextEntryModel descriptionField = TextEntryModel();
  final TextEntryModel priceField = TextEntryModel();
  StoreModel? selectedStore;
  var requiredCard = false;
  var createButtonClicked = false;
  DateTime? saleEnds;
  late final PanelController _imagePickPanelController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      // appBar: AppBar(
      //   title: Text(
      //     'create_post_title'.tr(),
      //     style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
      //   ),
      // ),
      body: LayoutBuilder(builder: (context, constraints) {
        return SlidingUpPanel(
          controller: _imagePickPanelController,
          borderRadius: BorderRadius.circular(16),
          minHeight: 0,
          maxHeight: 400,
          panelBuilder: (ScrollController sc) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 30,
                ),
                SizedBox(
                  height: 320,
                  width: constraints.maxWidth * 0.4,
                  child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<CreatePostBloc>(context).add(const PickImage(isCamera: false));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.upload),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  height: 320,
                  width: constraints.maxWidth * 0.4,
                  child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<CreatePostBloc>(context).add(const PickImage(isCamera: true));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.camera_alt_outlined),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
              ],
            );
          },
          body: SingleChildScrollView(
            child: SizedBox(
              width: constraints.maxWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: constraints.maxWidth * 0.95,
                    child: Card(
                      elevation: 7,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 6),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 320,
                              child: Stack(
                                children: [
                                  BlocBuilder<CreatePostBloc, CreatePostState>(builder: (context, state) {
                                    return state.maybeMap(initial: (initial) {
                                      return CachedNetworkImage(
                                        imageUrl: 'https://wwrhodyufftnwdbafguo.supabase.co/storage/v1/object/public/profile_pics/zeleny-kocur.jpg',
                                        imageBuilder: (context, imageProvider) => Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          )),
                                        ),
                                      );
                                    }, imagePicked: (imagePicked) {
                                      return Image.file(
                                        imagePicked.image,
                                        fit: BoxFit.fitHeight,
                                      );
                                    }, orElse: () {
                                      return const AppProgress();
                                    });
                                  }),
                                  Positioned(
                                    right: 2,
                                    top: 4,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6),
                                        child: Text(
                                          'Obchod',
                                          style: Theme.of(context).textTheme.bodyMedium,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 2,
                                    bottom: 4,
                                    child: Card(
                                      elevation: 10,
                                      color: Colors.yellowAccent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          '--,-- Kč',
                                          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
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
                                        child: EditableText(
                                          initialText: 'Přidat popisek....',
                                          theme: Theme.of(context).textTheme.bodyMedium!,
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
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 60,
                    child: Row(
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
                            context: context,
                            filled: App.appTheme.colorScheme.surface,
                            keyboardType: TextInputType.number,
                            hint: 'price_post_create_label'.tr(),
                            beginEdit: (te) {
                              te.model.error = null;
                              setState(() {});
                            },
                            validators: [
                              ValidatorEmpty(),
                              ValidatorRegex(r'^\d{1,5}(?:[.,]\d{1,2})?$', 'invalid number'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Text(
                        'card_required_label'.tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      SizedBox(
                        child: StoreCardPicker(
                          onChange: (card) {
                            requiredCard = card;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      Text(
                        '${'sale_ends_in_label'.tr()}*',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      SizedBox(
                        height: 60,
                        child: ValidUntilPicker(
                          validUntilPicked: (date) {
                            saleEnds = date;
                          },
                          constraints: constraints,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 50,
                    width: 270,
                    child: BlocBuilder<CreatePostBloc, CreatePostState>(builder: (context, state) {
                      return state.maybeWhen(imagePicked: (image) {
                        return AppButton(
                          backgroundColor: App.appTheme.colorScheme.primary,
                          radius: 6,
                          text: 'button_post_create_label'.tr(),
                          textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                          onClick: () async {
                            // Prevent multiple clicks
                            if (createButtonClicked) {
                              return;
                            }

                            // Prevent empty store
                            if (selectedStore == null) {
                              BlocProvider.of<SnackbarBloc>(context).add(const ErrorSnackbar(message: 'No store selected'));

                              return;
                            }
                            descriptionField.controller.text.trim();
                            //Validate fields
                            final valid = await TextEntryModel.validateFields([priceField, descriptionField]);
                            if (!valid) {
                              setState(() {});

                              return;
                            }

                            createButtonClicked = true;

                            BlocProvider.of<CreatePostBloc>(context).add(CreatePost(
                              description: descriptionField.text,
                              price: double.parse(priceField.text.replaceAll(',', '.')),
                              store: selectedStore!,
                              cardRequired: requiredCard,
                              image: image,
                              validUntil: saleEnds,
                            ));
                          },
                        );
                      }, orElse: () {
                        return AppButton(
                          backgroundColor: Colors.grey,
                          radius: 6,
                          text: 'button_post_create_label'.tr(),
                          textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                          onClick: () {},
                        );
                      });
                    }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    '* ${'field_not_mandatory_label'.tr()}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class EditableText extends StatefulWidget {
  final String initialText;
  final TextStyle theme;
  const EditableText({super.key, required this.initialText, required this.theme});

  @override
  _EditableTextState createState() => _EditableTextState();
}

class _EditableTextState extends State<EditableText> {
  bool isEditing = false;
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  String displayText = '';
  @override
  void initState() {
    displayText = widget.initialText;
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        setState(() {
          isEditing = false;
          displayText = controller.text;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isEditing = true;
          controller.text = displayText;
          FocusScope.of(context).requestFocus(focusNode);
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isEditing
            ? TextField(
                controller: controller,
                focusNode: focusNode,
                autofocus: true,
                onSubmitted: (value) {
                  setState(() {
                    isEditing = false;
                    displayText = value;
                  });
                },
              )
            : Text(
                displayText,
                style: widget.theme,
              ),
      ),
    );
  }
}
