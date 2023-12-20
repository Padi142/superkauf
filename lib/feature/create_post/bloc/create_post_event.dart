part of 'create_post_bloc.dart';

abstract class CreatePostEvent extends Equatable {
  const CreatePostEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends CreatePostEvent {
  const InitialEvent();
}

class UploadImage extends CreatePostEvent {
  final bool isCamera;

  const UploadImage({
    required this.isCamera,
  });
}

class CreatePost extends CreatePostEvent {
  final String description;
  final double price;
  final StoreModel store;
  final String image;

  const CreatePost({
    required this.description,
    required this.price,
    required this.store,
    required this.image,
  });
}
