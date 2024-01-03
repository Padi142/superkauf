import 'package:superkauf/generic/post/model/pagination_model.dart';

class GetStorePostsParams {
  final int storeId;
  final int? userId;
  final GetPostsPaginationModel pagination;

  GetStorePostsParams({
    required this.storeId,
    this.userId,
    required this.pagination,
  });
}
