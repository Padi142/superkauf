import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superkauf/generic/label/model/get_labels_params.dart';
import 'package:superkauf/generic/label/use_case/get_labels_use_case.dart';

import 'label_state.dart';

part 'label_event.dart';

class LabelBloc extends Bloc<LabelEvent, LabelState> {
  final GetLabelsUseCase getLabelsUseCase;

  LabelBloc({
    required this.getLabelsUseCase,
  }) : super(const LabelState.loading()) {
    on<SearchLabel>(_onSearchLabel);
  }

  var userId = -1;

  Future<void> _onSearchLabel(
    SearchLabel event,
    Emitter<LabelState> emit,
  ) async {
    emit(const LabelState.loading());
    final params = GetLabelsParams(query: event.query, page: 0, limit: 10);
    final result = await getLabelsUseCase.call(params);

    result.map(
      failure: (error) {
        emit(LabelState.error(error.message));
      },
      success: (success) {
        emit(LabelState.loaded(success.labels));
      },
    );
  }
}
