part of 'shopping_list_bloc.dart';

abstract class ShoppingListEvent extends Equatable {
  const ShoppingListEvent();

  @override
  List<Object> get props => [];
}

class GetShoppingList extends ShoppingListEvent {
  const GetShoppingList();
}

class ReloadShoppingList extends ShoppingListEvent {
  final bool wait;

  const ReloadShoppingList({this.wait = false});
}

class LoadMore extends ShoppingListEvent {
  const LoadMore();
}

class UpdateSavedPostEvent extends ShoppingListEvent {
  final int postId;
  final bool isCompleted;

  const UpdateSavedPostEvent({
    required this.postId,
    required this.isCompleted,
  });
}
