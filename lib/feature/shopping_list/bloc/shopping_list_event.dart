part of 'shopping_list_bloc.dart';

abstract class ShoppingListEvent extends Equatable {
  const ShoppingListEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends ShoppingListEvent {
  const InitialEvent();
}

class ReloadShoppingList extends ShoppingListEvent {
  final bool wait;

  const ReloadShoppingList({this.wait = false});
}

class LoadMore extends ShoppingListEvent {
  const LoadMore();
}

class PickStore extends ShoppingListEvent {
  final StoreModel store;
  const PickStore({required this.store});
}

class PickShoppingList extends ShoppingListEvent {
  final int shoppingListId;
  const PickShoppingList({
    required this.shoppingListId,
  });
}
