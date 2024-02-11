import 'package:superkauf/generic/post/model/pagination_model.dart';

class GetStorePostsParams {
  final int storeId;
  final int? userId;
  final GetPostsPaginationModel pagination;
  final String country;

  GetStorePostsParams({
    required this.storeId,
    this.userId,
    required this.pagination,
    required this.country,
  });
}
