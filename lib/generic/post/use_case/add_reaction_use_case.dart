import 'package:superkauf/generic/post/data/post_repository.dart';
import 'package:superkauf/generic/post/model/models/add_reaction_model.dart';
import 'package:superkauf/generic/post/model/results/reactions_result.dart';
import 'package:superkauf/library/use_case.dart';

class AddReactionUseCase extends UseCase<ReactionsResult, ({AddReactionModel model, String token})> {
  PostsRepository repository;

  AddReactionUseCase({
    required this.repository,
  });

  @override
  Future<ReactionsResult> call(params) async {
    return await repository.addReaction(params.model, params.token);
  }
}
