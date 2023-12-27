import 'package:superkauf/generic/post/data/post_repository.dart';
import 'package:superkauf/generic/post/model/models/add_reaction_model.dart';
import 'package:superkauf/generic/post/model/results/reactions_result.dart';
import 'package:superkauf/library/use_case.dart';

class RemoveReactionUseCase extends UseCase<ReactionsResult, RemoveReactionModel> {
  PostsRepository repository;

  RemoveReactionUseCase({
    required this.repository,
  });

  @override
  Future<ReactionsResult> call(params) async {
    return await repository.removeReaction(params);
  }
}
