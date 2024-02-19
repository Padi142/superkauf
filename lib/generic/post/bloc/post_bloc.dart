import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:superkauf/generic/post/bloc/post_state.dart';
import 'package:superkauf/generic/post/model/delete_post_body.dart';
import 'package:superkauf/generic/post/model/models/add_reaction_model.dart';
import 'package:superkauf/generic/post/model/update_post_body.dart';
import 'package:superkauf/generic/post/use_case/add_reaction_use_case.dart';
import 'package:superkauf/generic/post/use_case/delete_post_use_case.dart';
import 'package:superkauf/generic/post/use_case/remove_reaction_use_case.dart';
import 'package:superkauf/generic/post/use_case/update_post_use_case.dart';
import 'package:superkauf/generic/report/model/create_report_body.dart';
import 'package:superkauf/generic/report/user_case/create_report_use_case.dart';
import 'package:superkauf/generic/saved_posts/model/create_saved_post_body.dart';
import 'package:superkauf/generic/saved_posts/model/delete_saved_post_body.dart';
import 'package:superkauf/generic/saved_posts/use_case/create_saved_post_use_case.dart';
import 'package:superkauf/generic/saved_posts/use_case/delete_saved_post_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_current_user_use_case.dart';
import 'package:superkauf/generic/user/use_case/get_user_by_uid_use_case.dart';

part 'post_event.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final DeletePostUseCase deletePostUseCase;
  final GetUserByUidUseCase getUserByUidUseCase;
  final CreateSavedPostUseCase createSavedPostUseCase;
  final DeleteSavedPostUseCase deleteSavedPostUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final UpdatePostUseCase updatePostUseCase;
  final UpdatePostValidUntilUseCase updatePostValidUntilUseCase;
  final AddReactionUseCase addReactionUseCase;
  final RemoveReactionUseCase removeReactionUseCase;
  final CreateReportUseCase createReportUseCase;

  PostBloc({
    required this.deletePostUseCase,
    required this.getUserByUidUseCase,
    required this.createSavedPostUseCase,
    required this.deleteSavedPostUseCase,
    required this.getCurrentUserUseCase,
    required this.updatePostUseCase,
    required this.updatePostValidUntilUseCase,
    required this.addReactionUseCase,
    required this.removeReactionUseCase,
    required this.createReportUseCase,
  }) : super(const PostState.loading()) {
    on<DeletePost>(_onDeletePost);
    on<SavePost>(_onSavePost);
    on<UpdatePost>(_onUpdatePost);
    on<UpdatePostValidUntilEvent>(_onUpdatePostValidUntilEvent);
    on<RemoveSavedPost>(_onRemoveSavedPost);
    on<AddReaction>(_onAddReaction);
    on<RemoveReaction>(_onRemoveReaction);
    on<ReportPost>(_onReportPost);
  }

  Future<void> _onDeletePost(
    DeletePost event,
    Emitter<PostState> emit,
  ) async {
    emit(const PostState.loading());
    var userId = -1;

    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    if (user == null) {
      emit(const PostState.error("You are not logged in"));
      return;
    }

    final userResult = await getUserByUidUseCase.call(user.id);
    userResult.map(
      success: (success) {
        if (success.user.id != event.author && !success.user.isAdmin) {
          emit(const PostState.error("You are not the author of this post"));
          return;
        }
        userId = success.user.id;
      },
      failure: (failure) {
        emit(const PostState.error("You probably dont exist :/// "));
        return;
      },
    );

    final params = DeletePostBody(postId: event.postId, author: userId.toString());

    final result = await deletePostUseCase.call(params);
    result.when(
      success: () {
        Posthog().capture(eventName: 'post_deleted', properties: {
          'post_id': params.postId,
        });

        emit(const PostState.success());
      },
      failure: (message) {
        emit(PostState.error(message));
      },
    );
  }

  Future<void> _onSavePost(
    SavePost event,
    Emitter<PostState> emit,
  ) async {
    final user = await getCurrentUserUseCase.call();
    if (user == null) {
      emit(const PostState.error("You are not logged in"));
      return;
    }

    final params = CreateSavedPostBody(post: event.postId, user: user.id);
    final result = await createSavedPostUseCase.call(params);
    result.map(
      success: (value) async {
        Posthog().capture(eventName: 'post_saved', properties: {
          'post_id': params.post,
        });

        emit(const PostState.success());
      },
      failure: (message) async {
        emit(PostState.error(message.message));
      },
    );
  }

  Future<void> _onUpdatePost(
    UpdatePost event,
    Emitter<PostState> emit,
  ) async {
    final user = await getCurrentUserUseCase.call();
    if (user == null) {
      emit(const PostState.error("You are not logged in"));
      return;
    }

    final params = UpdatePostBody(postId: event.postId, content: event.newDescription, user: user.id);
    final result = await updatePostUseCase.call(params);
    result.map(
      success: (value) async {
        Posthog().capture(eventName: 'post_updated', properties: {
          'post_id': params.postId,
        });

        emit(const PostState.success());
      },
      failure: (message) async {
        emit(PostState.error(message.message));
      },
    );
  }

  Future<void> _onUpdatePostValidUntilEvent(
    UpdatePostValidUntilEvent event,
    Emitter<PostState> emit,
  ) async {
    final user = await getCurrentUserUseCase.call();
    if (user == null) {
      emit(const PostState.error("You are not logged in"));
      return;
    }

    final params = UpdatePostValidUntilBody(postId: event.postId, validUntil: event.newValidUntil, user: user.id);
    final result = await updatePostValidUntilUseCase.call(params);
    result.map(
      success: (value) async {
        Posthog().capture(eventName: 'post_sale_end_updated', properties: {
          'post_id': params.postId,
        });

        emit(const PostState.success());
      },
      failure: (message) async {
        emit(PostState.error(message.message));
      },
    );
  }

  Future<void> _onRemoveSavedPost(
    RemoveSavedPost event,
    Emitter<PostState> emit,
  ) async {
    final user = await getCurrentUserUseCase.call();
    if (user == null) {
      emit(const PostState.error("You are not logged in"));
      return;
    }

    final params = DeleteSavedPostBody(savedPostId: event.postId, user: user.id);
    final result = await deleteSavedPostUseCase.call(params);
    result.map(
      success: (value) {
        Posthog().capture(eventName: 'post_unsaved', properties: {
          'post_id': event.postId,
        });

        emit(const PostState.success());
      },
      failure: (message) {
        emit(PostState.error(message.message));
      },
    );
  }

  Future<void> _onAddReaction(
    AddReaction event,
    Emitter<PostState> emit,
  ) async {
    final user = await getCurrentUserUseCase.call();
    if (user == null) {
      emit(const PostState.error("You are not logged in"));
      return;
    }

    final params = AddReactionModel(post: event.postId, user: user.id, type: 'like');
    final result = await addReactionUseCase.call(params);
    result.map(
      success: (value) async {
        Posthog().capture(eventName: 'post_liked', properties: {
          'post_id': params.post,
        });

        emit(const PostState.success());
      },
      failure: (message) {
        emit(PostState.error(message.message));
      },
    );
  }

  Future<void> _onRemoveReaction(
    RemoveReaction event,
    Emitter<PostState> emit,
  ) async {
    final user = await getCurrentUserUseCase.call();
    if (user == null) {
      emit(const PostState.error("You are not logged in"));
      return;
    }

    final params = RemoveReactionModel(post: event.postId, user: user.id, type: 'like');
    final result = await removeReactionUseCase.call(params);
    result.map(
      success: (value) {
        Posthog().capture(eventName: 'post_unliked', properties: {
          'post_id': params.post,
        });

        emit(const PostState.success());
      },
      failure: (message) {
        emit(PostState.error(message.message));
      },
    );
  }

  Future<void> _onReportPost(
    ReportPost event,
    Emitter<PostState> emit,
  ) async {
    final user = await getCurrentUserUseCase.call();
    if (user == null) {
      emit(const PostState.error("You are not logged in"));
      return;
    }

    final params = CreateReportBody(reportedPost: event.postId, reportedBy: user.id, type: 'post');
    final result = await createReportUseCase.call(params);
    result.map(
      success: (value) {
        Posthog().capture(eventName: 'post_reported', properties: {
          'post_id': params.reportedPost!,
        });

        emit(const PostState.success());
      },
      failure: (message) {
        emit(PostState.error(message.message));
      },
    );
  }
}
