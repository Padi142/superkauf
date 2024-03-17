import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:superkauf/generic/label/model/create_label_body.dart';
import 'package:superkauf/generic/label/model/label_model.dart';

part 'label_api.g.dart';

@RestApi()
abstract class LabelApi {
  factory LabelApi(Dio dio) = _LabelApi;

  @GET('/labels?query={query}&limit={limit}&page={page}')
  Future<List<LabelModel>> getLabels({
    @Path() required String query,
    @Path() required int limit,
    @Path() required int page,
  });

  @POST('/labels')
  Future<LabelModel> createLabel({
    @Body() required CreateLabelBody label,
  });
}
