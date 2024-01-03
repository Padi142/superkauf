import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:superkauf/feature/create_post/bloc/create_post_state.dart';
import 'package:superkauf/feature/create_post/use_case/create_post_navigation.dart';
import 'package:superkauf/feature/create_post/use_case/pick_image_camera_use_case.dart';
import 'package:superkauf/feature/create_post/use_case/pick_image_use_case.dart';
import 'package:superkauf/generic/post/model/create_post_model.dart';
import 'package:superkauf/generic/post/model/post_model.dart';
import 'package:superkauf/generic/post/model/update_post_image_body.dart';
import 'package:superkauf/generic/post/model/upload_post_image_params.dart';
import 'package:superkauf/generic/post/use_case/create_post_use_case.dart';
import 'package:superkauf/generic/post/use_case/update_post_image_use_case.dart';
import 'package:superkauf/generic/post/use_case/upload_post_image_use_case.dart';
import 'package:superkauf/generic/store/model/store_model.dart';
import 'package:superkauf/generic/store/use_case/get_stores_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_current_user_use_case.dart';

part 'create_post_event.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  final CreatePostUseCase createPostUseCase;
  final UploadPostImageUseCase uploadPostImageUseCase;
  final PickImageUseCase pickImageUseCase;
  final CreatePostNavigation createPostNavigation;
  final PickImageCameraUseCase pickImageCameraUseCase;
  final GetStoresUseCase getStoresUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final UpdatePostImageUseCase updatePostImageUseCase;

  CreatePostBloc({
    required this.createPostUseCase,
    required this.uploadPostImageUseCase,
    required this.pickImageUseCase,
    required this.createPostNavigation,
    required this.pickImageCameraUseCase,
    required this.getStoresUseCase,
    required this.getCurrentUserUseCase,
    required this.updatePostImageUseCase,
  }) : super(const CreatePostState.loading()) {
    on<UploadImage>(_onUploadImage);
    on<PickImage>(_onPickImage);
    on<CreatePost>(_onCreatePost);
    on<InitialEvent>(_onInitialEvent);
  }

  Future<void> _onInitialEvent(
    InitialEvent event,
    Emitter<CreatePostState> emit,
  ) async {
    final user = await getCurrentUserUseCase.call();
    if (user == null) {
      emit(const CreatePostState.error('User not found, are you logged in?'));
      return;
    }
    emit(const CreatePostState.initial());
  }

  var userID = -1;

  Future<void> _onPickImage(
    PickImage event,
    Emitter<CreatePostState> emit,
  ) async {
    late File? image;
    if (event.isCamera) {
      image = await pickImageCameraUseCase.call();
    } else {
      image = await pickImageUseCase.call();
    }

    if (image == null) {
      emit(const CreatePostState.error('No image selected'));
      add(const InitialEvent());
      return;
    }

    emit(CreatePostState.imagePicked(image));
  }

  Future<void> _onUploadImage(
    UploadImage event,
    Emitter<CreatePostState> emit,
  ) async {
    final supabase = Supabase.instance.client;

    emit(const CreatePostState.loading());

    final params = UploadImageParams(file: event.image, path: userID.toString());
    final result = await uploadPostImageUseCase.call(params);

    var imageLink = '';
    result.map(
      success: (success) {
        imageLink = supabase.storage.from('posts').getPublicUrl(
              success.path,
            );
        emit(CreatePostState.imageUploaded(imageLink));
      },
      failure: (error) {
        emit(CreatePostState.error(error.message));
      },
    );

    final imageUpdateResult = await updatePostImageUseCase.call(UpdatePostImageBody(
      postId: event.postId,
      image: imageLink,
      user: userID,
    ));

    imageUpdateResult.map(
      success: (success) {
        emit(const CreatePostState.success());
        createPostNavigation.goBack();
      },
      failure: (error) {
        emit(CreatePostState.error(error.message));
      },
    );
  }

  Future<void> _onCreatePost(
    CreatePost event,
    Emitter<CreatePostState> emit,
  ) async {
    final user = await getCurrentUserUseCase.call();

    if (user == null) {
      emit(const CreatePostState.error('User not found, are you logged in?'));
      return;
    }
    userID = user.id;

    final params = CreatePostModel(
      description: event.description,
      price: event.price,
      storeName: event.store.name,
      store: event.store.id,
      requiresStoreCard: event.cardRequired,
      author: userID.toString(),
      validUntil: event.validUntil,
    );

    final result = await createPostUseCase.call(params);

    PostModel? post;
    result.map(
      success: (success) {
        post = success.post;
        // createPostNavigation.goBack();
      },
      failure: (error) {
        emit(CreatePostState.error(error.message));
        return;
      },
    );
    if (post != null) {
      add(UploadImage(image: event.image, postId: post!.id));
    }
  }
}
