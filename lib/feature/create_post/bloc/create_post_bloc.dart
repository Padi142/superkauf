import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:superkauf/feature/create_post/bloc/create_post_state.dart';
import 'package:superkauf/feature/create_post/use_case/create_post_navigation.dart';
import 'package:superkauf/feature/create_post/use_case/pick_image_use_case.dart';
import 'package:superkauf/generic/post/model/create_post_model.dart';
import 'package:superkauf/generic/post/model/upload_post_image_params.dart';
import 'package:superkauf/generic/post/use_case/create_post_use_case.dart';
import 'package:superkauf/generic/post/use_case/upload_post_image_use_case.dart';

part 'create_post_event.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  final CreatePostUseCase createPostUseCase;
  final UploadPostImageUseCase uploadPostImageUseCase;
  final PickImageUseCase pickImageUseCase;
  final CreatePostNavigation createPostNavigation;

  CreatePostBloc({
    required this.createPostUseCase,
    required this.uploadPostImageUseCase,
    required this.pickImageUseCase,
    required this.createPostNavigation,
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

  Future<void> _onUploadImage(
    UploadImage event,
    Emitter<CreatePostState> emit,
  ) async {
    final image = await pickImageUseCase.call();
    if (image == null) {
      emit(const CreatePostState.error('No image selected'));
      return;
    }

    final date = DateFormat('mm:HH:dd:MM:yyyy').format(DateTime.now());
    //TODO get user id
    const userID = '1';
    final params = UploadPostImageParams(file: image, path: "$userID/$date");
    final result = await uploadPostImageUseCase.call(params);

    final supabase = Supabase.instance.client;

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
      storeName: event.storeName,
      image: event.image,
      author: '1',
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
