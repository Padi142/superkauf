part of 'create_post_bloc.dart';

abstract class CreatePostEvent extends Equatable {
  const CreatePostEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends CreatePostEvent {
  const InitialEvent();
}

class PickImage extends CreatePostEvent {
  final bool isCamera;

  const PickImage({
    required this.isCamera,
  });
}

class UploadImage extends CreatePostEvent {
  final File image;
  final int postId;

  const UploadImage({
    required this.image,
    required this.postId,
  });
}

class CreatePost extends CreatePostEvent {
  final String description;
  final double price;
  final StoreModel store;
  final bool cardRequired;
  final File image;
  final DateTime? validUntil;

  const CreatePost({
    required this.description,
    required this.price,
    required this.store,
    required this.cardRequired,
    required this.image,
    required this.validUntil,
  });
}
