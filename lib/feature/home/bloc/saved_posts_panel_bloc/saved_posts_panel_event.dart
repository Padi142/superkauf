part of 'saved_posts_panel_bloc.dart';

abstract class SavedPostsPanelEvent extends Equatable {
  const SavedPostsPanelEvent();

  @override
  List<Object> get props => [];
}

class OpenSavedPostsPanel extends SavedPostsPanelEvent {
  final int storeId;
  final int postId;

  const OpenSavedPostsPanel({
    required this.storeId,
    required this.postId,
  });
}

class Initial extends SavedPostsPanelEvent {
  final int storeId;
  final int postId;

  const Initial({
    required this.storeId,
    required this.postId,
  });
}
