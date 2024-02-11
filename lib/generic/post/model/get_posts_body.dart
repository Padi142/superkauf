import 'package:json_annotation/json_annotation.dart';
import 'package:superkauf/generic/post/model/pagination_model.dart';

part 'get_posts_body.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class GetPostsBody {
  final GetPostsPaginationModel pagination;
  final String country;

  const GetPostsBody({
    required this.pagination,
    required this.country,
  });

  factory GetPostsBody.fromJson(Map<String, dynamic> json) => _$GetPostsBodyFromJson(json);

  Map<String, dynamic> toJson() => _$GetPostsBodyToJson(this);
}
