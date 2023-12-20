import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:superkauf/feature/create_post/bloc/create_post_state.dart';
import 'package:superkauf/feature/create_post/use_case/create_post_navigation.dart';
import 'package:superkauf/feature/create_post/use_case/pick_image_camera_use_case.dart';
import 'package:superkauf/feature/create_post/use_case/pick_image_use_case.dart';
import 'package:superkauf/generic/post/model/create_post_model.dart';
import 'package:superkauf/generic/post/model/upload_post_image_params.dart';
import 'package:superkauf/generic/post/use_case/create_post_use_case.dart';
import 'package:superkauf/generic/post/use_case/upload_post_image_use_case.dart';
import 'package:superkauf/generic/store/model/store_model.dart';
import 'package:superkauf/generic/store/use_case/get_stores_use_case.dart';

import '../../../generic/user/use_case/get_user_by_uid_use_case.dart';

part 'create_post_event.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  final CreatePostUseCase createPostUseCase;
  final UploadPostImageUseCase uploadPostImageUseCase;
  final PickImageUseCase pickImageUseCase;
  final CreatePostNavigation createPostNavigation;
  final GetUserByUidUseCase getUserByUidUseCase;
  final PickImageCameraUseCase pickImageCameraUseCase;
  final GetStoresUseCase getStoresUseCase;

  CreatePostBloc({
    required this.createPostUseCase,
    required this.uploadPostImageUseCase,
    required this.pickImageUseCase,
    required this.createPostNavigation,
    required this.getUserByUidUseCase,
    required this.pickImageCameraUseCase,
    required this.getStoresUseCase,
  }) : super(const CreatePostState.loading()) {
    on<UploadImage>(_onUploadImage);
    on<CreatePost>(_onCreatePost);
    on<InitialEvent>(_onInitialEvent);
  }

  Future<void> _onInitialEvent(
    InitialEvent event,
    Emitter<CreatePostState> emit,
  ) async {
    emit(const CreatePostState.initial());
  }

  var userID = -1;

  Future<void> _onUploadImage(
    UploadImage event,
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
      return;
    }

    emit(const CreatePostState.loading());

    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) {
      emit(const CreatePostState.error('User not found'));
      return;
    }

    final date = DateFormat('mm:HH:dd:MM:yyyy').format(DateTime.now());
    final userResult = await getUserByUidUseCase.call(user.id);
    userResult.when(
      success: (success) {
        userID = success.id;
      },
      failure: (message) {
        emit(CreatePostState.error(message));
        return;
      },
    );

    final params = UploadPostImageParams(file: image, path: "$userID/$date");
    final result = await uploadPostImageUseCase.call(params);

    final imageLink = supabase.storage.from('posts').getPublicUrl("$userID/$date");

    result.map(
      success: (success) {
        emit(CreatePostState.imageUploaded(imageLink));
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
    final params = CreatePostModel(
      description: event.description,
      price: event.price,
      storeName: event.store.name,
      store: event.store.id,
      image: event.image,
      author: userID.toString(),
    );

    final result = await createPostUseCase.call(params);

    result.map(
      success: (success) {
        emit(const CreatePostState.success());
        createPostNavigation.goBack();
      },
      failure: (error) {
        emit(CreatePostState.error(error.message));
      },
    );
  }
}
