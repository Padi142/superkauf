import 'package:superkauf/generic/post/model/pagination_model.dart';

class GetSavedPostsParams {
  final int userId;
  final GetPostsPaginationModel pagination;

  GetSavedPostsParams({
    required this.userId,
    required this.pagination,
  });
}
