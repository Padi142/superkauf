import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superkauf/feature/shopping_list/bloc/shopping_list_state.dart';
import 'package:superkauf/generic/saved_posts/use_case/get_saved_posts_by_user_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_current_user_use_case.dart';

part 'shopping_list_event.dart';

class ShoppingListBloc extends Bloc<ShoppingListEvent, ShoppingListState> {
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final GetSavedPostsByUserUseCase getSavedPostsByUserUseCase;

  ShoppingListBloc({
    required this.getCurrentUserUseCase,
    required this.getSavedPostsByUserUseCase,
  }) : super(const ShoppingListState.loading()) {
    on<GetShoppingList>(_onGetShoppingList);
    on<ReloadShoppingList>(_onReloadShoppingList);
  }

  Future<void> _onGetShoppingList(
    GetShoppingList event,
    Emitter<ShoppingListState> emit,
  ) async {
    final userResult = await getCurrentUserUseCase.call();
    if (userResult == null) {
      emit(const ShoppingListState.error("You are not logged in"));
      return;
    }

    final result = await getSavedPostsByUserUseCase.call(userResult.id);

    result.map(success: (success) {
      emit(ShoppingListState.loaded(success.posts));
    }, failure: (failure) {
      emit(ShoppingListState.error(failure.message));
    });
  }

  Future<void> _onReloadShoppingList(
    ReloadShoppingList event,
    Emitter<ShoppingListState> emit,
  ) async {
    if (event.wait) {
      await Future.delayed(const Duration(milliseconds: 400));
    }
    emit(const ShoppingListState.loading());
    add(const GetShoppingList());
  }
}
