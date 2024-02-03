import 'package:superkauf/generic/post/data/post_repository.dart';
import 'package:superkauf/generic/post/model/get_fullcontext_post_detail_result.dart';
import 'package:superkauf/generic/post/model/results/get_post_detail_params.dart';
import 'package:superkauf/library/use_case.dart';

class GetPostDetailUseCase
    extends UseCase<GetFullContextPostDetailResult, GetPostDetailParams> {
  PostsRepository repository;

  GetPostDetailUseCase({
    required this.repository,
  });

  @override
  Future<GetFullContextPostDetailResult> call(params) async {
    return await repository.getPostDetail(params.postId, params.userId);
  }
}
