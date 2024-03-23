import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superkauf/generic/shopping_list/bloc/shopping_list_data_state.dart';
import 'package:superkauf/generic/shopping_list/model/add_saved_post_to_list_body.dart';
import 'package:superkauf/generic/shopping_list/model/create_shopping_list_body.dart';
import 'package:superkauf/generic/shopping_list/model/join_shopping_list_body.dart';
import 'package:superkauf/generic/shopping_list/use_case/add_saved_post_to_list_use_case.dart';
import 'package:superkauf/generic/shopping_list/use_case/create_shopping_list_use_case.dart';
import 'package:superkauf/generic/shopping_list/use_case/delete_list_use_case.dart';
import 'package:superkauf/generic/shopping_list/use_case/get_shopping_list_info_use_case.dart';
import 'package:superkauf/generic/shopping_list/use_case/join_user_to_list_use_case.dart';
import 'package:superkauf/generic/shopping_list/use_case/remove_post_from_list_use_case.dart';
import 'package:superkauf/generic/shopping_list/use_case/remove_user_from_list_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_current_user_use_case.dart';

part 'shopping_list_data_event.dart';

class ShoppingListDataBloc extends Bloc<ShoppingListDataEvent, ShoppingListDataState> {
  final AddSavedPostToListUseCase addSavedPostToListUseCase;
  final RemovePostFromListUseCase removePostFromListUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final CreateShoppingListUseCase createShoppingListUseCase;
  final JoinUserToShoppingListUseCase joinShoppingListUseCase;
  final RemoveUserFromShoppingListUseCase removeUserFromShoppingListUseCase;
  final DeleteListUseCase deleteListUseCase;
  final GetShoppingListInfoUseCase getShoppingListInfoUseCase;

  ShoppingListDataBloc({
    required this.addSavedPostToListUseCase,
    required this.removePostFromListUseCase,
    required this.getCurrentUserUseCase,
    required this.createShoppingListUseCase,
    required this.joinShoppingListUseCase,
    required this.removeUserFromShoppingListUseCase,
    required this.deleteListUseCase,
    required this.getShoppingListInfoUseCase,
  }) : super(const ShoppingListDataState.loading()) {
    on<AddPostToList>(_onAddPostToList);
    on<RemovePostFromList>(_onRemovePostFromList);
    on<CreateList>(_onCreateList);
    on<JoinList>(_onJoinList);
    on<LeaveList>(_onLeaveList);
    on<DeleteList>(_onDeleteList);
  }

  Future<void> _onAddPostToList(
    AddPostToList event,
    Emitter<ShoppingListDataState> emit,
  ) async {
    final userResult = await getCurrentUserUseCase.call(false);

    if (userResult == null) {
      return;
    }

    final result = await addSavedPostToListUseCase.call(
      AddSavedPostToListBody(
        listId: event.listId,
        postId: event.postId,
        userId: userResult.id,
      ),
    );
  }

  Future<void> _onRemovePostFromList(
    RemovePostFromList event,
    Emitter<ShoppingListDataState> emit,
  ) async {
    final userResult = await getCurrentUserUseCase.call(false);

    if (userResult == null) {
      return;
    }

    final result = await removePostFromListUseCase.call(
      AddSavedPostToListBody(
        listId: event.listId,
        postId: event.postId,
        userId: userResult.id,
      ),
    );
  }

  Future<void> _onCreateList(
    CreateList event,
    Emitter<ShoppingListDataState> emit,
  ) async {
    final userResult = await getCurrentUserUseCase.call(false);

    if (userResult == null) {
      return;
    }

    final result = await createShoppingListUseCase.call(
      CreateShoppingListBody(
        name: event.name,
        createdBy: userResult.id,
      ),
    );

    result.maybeMap(
        orElse: () {},
        success: (success) {
          emit(ShoppingListDataState.listJoined(success.list.id));
        },
        failure: (error) {
          emit(const ShoppingListDataState.error('Error creating list'));
        });

    emit(const ShoppingListDataState.loading());
  }

  Future<void> _onJoinList(
    JoinList event,
    Emitter<ShoppingListDataState> emit,
  ) async {
    final userResult = await getCurrentUserUseCase.call(false);

    if (userResult == null) {
      return;
    }

    final result = await joinShoppingListUseCase.call(
      JoinShoppingListBody(
        code: event.code.toUpperCase(),
        userId: userResult.id,
      ),
    );

    result.maybeMap(
        success: (success) {
          emit(ShoppingListDataState.listJoined(success.joined.shoppingListId));
        },
        orElse: () {},
        failure: (error) {
          emit(const ShoppingListDataState.error('Error joining list'));
        });

    emit(const ShoppingListDataState.loading());
  }

  Future<void> _onLeaveList(
    LeaveList event,
    Emitter<ShoppingListDataState> emit,
  ) async {
    final userResult = await getCurrentUserUseCase.call(false);

    if (userResult == null) {
      return;
    }

    final listResult = await getShoppingListInfoUseCase.call(event.listId);

    listResult.map(
        success: (success) {
          if (success.list.list.createdBy == userResult.id) {
            add(DeleteList(listId: event.listId));
            return;
          }
        },
        failure: (failure) {});

    final result = await removeUserFromShoppingListUseCase.call(
      DeleteShoppingListBody(
        listId: event.listId,
        userId: userResult.id,
      ),
    );

    result.maybeMap(
        orElse: () {},
        failure: (error) {
          emit(const ShoppingListDataState.error('Error leaving list'));
        });
    emit(const ShoppingListDataState.listLeaved());

    emit(const ShoppingListDataState.loading());
  }

  Future<void> _onDeleteList(
    DeleteList event,
    Emitter<ShoppingListDataState> emit,
  ) async {
    final userResult = await getCurrentUserUseCase.call(false);

    if (userResult == null) {
      return;
    }

    final result = await deleteListUseCase.call(
      DeleteShoppingListBody(
        listId: event.listId,
        userId: userResult.id,
      ),
    );

    result.maybeMap(
        orElse: () {},
        failure: (error) {
          emit(const ShoppingListDataState.error('Error deleting list'));
        });
    emit(const ShoppingListDataState.listDeleted());

    emit(const ShoppingListDataState.loading());
  }
}
