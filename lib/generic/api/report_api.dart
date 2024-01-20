import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:superkauf/generic/saved_posts/model/saved_post_model.dart';

part 'report_api.g.dart';

@RestApi()
abstract class ReportApi {
  factory ReportApi(Dio dio) = _ReportApi;

  @POST('/report')
  Future<SavedPostModel> createReport({
    @Body() required Map<String, dynamic> body,
  });
}
