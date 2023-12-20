import 'package:superkauf/generic/post/data/post_repository.dart';
import 'package:superkauf/generic/post/model/get_post_detail_result.dart';
import 'package:superkauf/library/use_case.dart';

class GetPostDetailUseCase extends UseCase<GetPostDetailResult, String> {
  PostsRepository repository;

  GetPostDetailUseCase({
    required this.repository,
  });

  @override
  Future<GetPostDetailResult> call(params) async {
    return await repository.getPostDetail(params);
  }
}
