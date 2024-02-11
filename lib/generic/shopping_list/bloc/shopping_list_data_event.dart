part of 'shopping_list_data_bloc.dart';

abstract class ShoppingListDataEvent extends Equatable {
  const ShoppingListDataEvent();

  @override
  List<Object> get props => [];
}

class AddPostToList extends ShoppingListDataEvent {
  final int listId;
  final int postId;

  const AddPostToList({
    required this.listId,
    required this.postId,
  });
}

class CreateList extends ShoppingListDataEvent {
  final String name;

  const CreateList({
    required this.name,
  });
}

class JoinList extends ShoppingListDataEvent {
  final String code;

  const JoinList({
    required this.code,
  });
}

class LeaveList extends ShoppingListDataEvent {
  final int listId;

  const LeaveList({
    required this.listId,
  });
}

class DeleteList extends ShoppingListDataEvent {
  final int listId;

  const DeleteList({
    required this.listId,
  });
}

class RemovePostFromList extends ShoppingListDataEvent {
  final int listId;
  final int savedPostId;

  const RemovePostFromList({
    required this.listId,
    required this.savedPostId,
  });
}
