import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:superkauf/feature/create_post/bloc/create_post_bloc.dart';
import 'package:superkauf/feature/create_post/bloc/create_post_state.dart';
import 'package:superkauf/feature/create_post/view/components/editable_text.dart';
import 'package:superkauf/feature/create_post/view/components/store_card_picker.dart';
import 'package:superkauf/feature/create_post/view/components/store_picker.dart';
import 'package:superkauf/feature/create_post/view/components/valid_until_picker.dart';
import 'package:superkauf/feature/snackbar/bloc/snackbar_bloc.dart';
import 'package:superkauf/generic/constants.dart';
import 'package:superkauf/generic/store/bloc/store_bloc.dart';
import 'package:superkauf/generic/store/bloc/store_state.dart';
import 'package:superkauf/generic/store/model/store_model.dart';
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
    _imagePickPanelController = PanelController();
    _storePickPanelController = PanelController();
    Future.delayed(const Duration(milliseconds: 400)).then((value) {
      if (_imagePickPanelController.isAttached) {
        _imagePickPanelController.open();
      }
    });
    super.initState();
  }

  final TextEntryModel descriptionField = TextEntryModel();
  TextEditingController descriptionController = TextEditingController();
  final TextEntryModel priceField = TextEntryModel();
  StoreModel? selectedStore;
  var requiredCard = false;
  var createButtonClicked = false;
  var storeNotPickedError = false;
  DateTime? saleEnds;
  late final PanelController _imagePickPanelController;
  late final PanelController _storePickPanelController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'create_post_title'.tr(),
          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return SlidingUpPanel(
          controller: _imagePickPanelController,
          backdropEnabled: true,
          backdropOpacity: 0.8,
          // defaultPanelState: PanelState.OPEN,
          borderRadius: BorderRadius.circular(16),
          minHeight: 0,
          maxHeight: 400,
          panelBuilder: (ScrollController sc) {
            return imagePanel(context, _imagePickPanelController, constraints);
          },
          body: SlidingUpPanel(
            controller: _storePickPanelController,
            backdropEnabled: true,
            backdropOpacity: 0.8,
            // defaultPanelState: PanelState.OPEN,
            borderRadius: BorderRadius.circular(16),
            isDraggable: false,
            minHeight: 0,
            maxHeight: 450,
            panelBuilder: (ScrollController sc) {
              return storePanel(context, _storePickPanelController, constraints, (store) {
                selectedStore = store;
                setState(() {});
              });
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
                      child: CreatePostContainer(
                        imagePickPanelController: _imagePickPanelController,
                        storePickPanelController: _storePickPanelController,
                        descriptionField: descriptionField,
                        priceField: priceField,
                        selectedStore: selectedStore,
                        constraints: constraints,
                        storeNotPickedError: selectedStore == null ? storeNotPickedError : false,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ExpandedPostSettings(
                        onCardRequiredChanged: (card) {
                          requiredCard = card;
                        },
                        onValidUntilChanged: (date) {
                          saleEnds = date;
                        },
                        constraints: constraints),
                    const SizedBox(
                      height: 30,
                    ),
                    //Create button
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
                                setState(() {
                                  storeNotPickedError = true;
                                });
                                Future.delayed(const Duration(milliseconds: 2500)).then((value) => setState(() {
                                      storeNotPickedError = false;
                                    }));

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
                            onClick: () {
                              BlocProvider.of<SnackbarBloc>(context).add(const ErrorSnackbar(message: 'No image selected'));
                            },
                          );
                        });
                      }),
                    ),
                    const SizedBox(
                      height: 600,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class CreatePostContainer extends StatelessWidget {
  final PanelController imagePickPanelController;
  final PanelController storePickPanelController;
  final TextEntryModel descriptionField;
  final TextEntryModel priceField;
  final BoxConstraints constraints;
  final StoreModel? selectedStore;
  final bool storeNotPickedError;

  const CreatePostContainer({
    super.key,
    required this.imagePickPanelController,
    required this.storePickPanelController,
    required this.descriptionField,
    required this.priceField,
    required this.selectedStore,
    required this.constraints,
    required this.storeNotPickedError,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      child: Padding(
        padding: const EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 6),
        child: Column(
          children: [
            SizedBox(
              height: 320,
              width: constraints.maxWidth * 0.95,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  BlocBuilder<CreatePostBloc, CreatePostState>(builder: (context, state) {
                    return state.maybeMap(initial: (initial) {
                      // if (selectedStore == null) {
                      //   imagePickPanelController.open();
                      // }

                      return GestureDetector(
                        onTap: () {
                          imagePickPanelController.open();
                        },
                        child: CachedNetworkImage(
                          imageUrl: 'https://wwrhodyufftnwdbafguo.supabase.co/storage/v1/object/public/profile_pics/zeleny-kocur.jpg',
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            )),
                          ),
                        ),
                      );
                    }, imagePicked: (imagePicked) {
                      return GestureDetector(
                        onTap: () {
                          BlocProvider.of<CreatePostBloc>(context).add(const InitialEvent());
                          imagePickPanelController.open();
                        },
                        child: Image.file(
                          imagePicked.image,
                          fit: BoxFit.fitHeight,
                        ),
                      );
                    }, uploading: (uploading) {
                      return const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppProgress(),
                          Text('Uploading image...'),
                        ],
                      );
                    }, creating: (creating) {
                      return const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppProgress(),
                          Text('Creating post...'),
                        ],
                      );
                    }, orElse: () {
                      return const AppProgress();
                    });
                  }),
                  Positioned(
                    right: 2,
                    top: 4,
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        BlocProvider.of<StoreBloc>(context).add(const GetAllStores());

                        storePickPanelController.open();
                      },
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(16.0),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          // Adjust animation duration
                          curve: Curves.easeIn,
                          // Adjust animation curve
                          decoration: BoxDecoration(
                            color: storeNotPickedError ? Colors.redAccent : Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Text(
                              selectedStore?.name ?? 'Obchod',
                              style: storeNotPickedError ? Theme.of(context).textTheme.titleMedium : Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
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
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            EditableTextField(
                              initialText: '--,--',
                              model: priceField,
                              width: null,
                              keyboardType: TextInputType.number,
                              filledColor: Colors.yellowAccent,
                              validators: [
                                ValidatorEmpty(),
                                ValidatorRegex(r'^\d{1,5}(?:[.,]\d{1,2})?$', 'invalid number'),
                              ],
                              theme: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
                            ),
                            Text(
                              'Kč',
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black),
                            )
                          ],
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
                        child: EditableTextField(
                          initialText: 'Přidat popisek....',
                          model: descriptionField,
                          width: constraints.maxWidth * 0.7,
                          filledColor: Colors.white,
                          maxLines: 2,
                          validators: [ValidatorEmpty(), ValidatorRegex(r'^.{5,250}$', 'Post can be 5-250 chars long')],
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
    );
  }
}

class ExpandedPostSettings extends StatelessWidget {
  final Function(bool) onCardRequiredChanged;
  final Function(DateTime) onValidUntilChanged;
  final BoxConstraints constraints;

  const ExpandedPostSettings({super.key, required this.onCardRequiredChanged, required this.onValidUntilChanged, required this.constraints});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('Více'),
      children: [
        StoreCardPicker(
          onChange: onCardRequiredChanged,
        ),
        const SizedBox(
          height: 15,
        ),
        ValidUntilPicker(
          validUntilPicked: onValidUntilChanged,
          constraints: constraints,
        ),
      ],
    );
  }
}

Widget imagePanel(BuildContext context, PanelController imagePickPanelController, BoxConstraints constraints) {
  return BlocBuilder<CreatePostBloc, CreatePostState>(builder: (context, state) {
    return state.maybeMap(initial: (initial) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 30,
          ),
          initial.canUploadFiles
              ? SizedBox(
                  height: 320,
                  width: constraints.maxWidth * 0.4,
                  child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<CreatePostBloc>(context).add(const PickImage(isCamera: false));
                      imagePickPanelController.close();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: App.appTheme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.upload),
                    ),
                  ),
                )
              : SizedBox(
                  height: 320,
                  width: constraints.maxWidth * 0.4,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.upload),
                            const Gap(5),
                            Text(
                              'cant_upload_image_label'.tr(args: [initial.requiredKarma.toString()]),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
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
                imagePickPanelController.close();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: App.appTheme.colorScheme.primary,
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
    }, orElse: () {
      return const AppProgress();
    });
  });
}

Widget storePanel(BuildContext context, PanelController storePickPanelController, BoxConstraints constraints, Function(StoreModel store) onStoreSelected) {
  return BlocBuilder<StoreBloc, StoreState>(builder: (context, state) {
    return state.maybeMap(success: (success) {
      return StoreCarousel(
        stores: success.stores,
        onStoreSelected: onStoreSelected,
        height: 250,
        panelController: storePickPanelController,
      );
    }, orElse: () {
      return const AppProgress();
    });
  });
}
