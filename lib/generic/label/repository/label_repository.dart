import 'package:dio/dio.dart';
import 'package:superkauf/generic/api/label_api.dart';
import 'package:superkauf/generic/label/model/create_label_body.dart';
import 'package:superkauf/generic/label/model/get_labels_params.dart';
import 'package:superkauf/generic/label/model/get_labels_result.dart';

class LabelRepository {
  final LabelApi labelApi;

  LabelRepository({
    required this.labelApi,
  });

  Future<GetLabelsResult> getLabels(GetLabelsParams params) async {
    return labelApi
        .getLabels(
      query: params.query,
      limit: params.limit,
      page: params.page,
    )
        .then((countries) {
      return GetLabelsResult.success(countries);
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return GetLabelsResult.failure(error.message ?? 'error getting labels');
      }
      return const GetLabelsResult.failure('error getting labels');
    });
  }

  Future<GetLabelsResult> createLabel(CreateLabelBody body) async {
    return labelApi
        .createLabel(
      label: body,
    )
        .then((countries) {
      return GetLabelsResult.success([countries]);
    }).onError((error, stackTrace) {
      if (error is DioException) {
        return GetLabelsResult.failure(error.message ?? 'error creating labels');
      }
      return const GetLabelsResult.failure('error creating labels');
    });
  }
}
