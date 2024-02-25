import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superkauf/generic/settings/use_case/get_settings_use_case.dart';
import 'package:superkauf/generic/store/bloc/store_state.dart';
import 'package:superkauf/generic/store/use_case/get_stores_use_case.dart';

part 'store_event.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final GetStoresUseCase getStoresUseCase;
  final GetSettingsUseCase getSettingsUseCase;

  StoreBloc({
    required this.getStoresUseCase,
    required this.getSettingsUseCase,
  }) : super(const StoreState.loading()) {
    on<GetAllStores>(_onGetFeed);
  }

  Future<void> _onGetFeed(
    GetAllStores event,
    Emitter<StoreState> emit,
  ) async {
    emit(const StoreState.loading());

    final settings = await getSettingsUseCase.call();

    final result = await getStoresUseCase.call(settings.country);
    result.when(
      success: (success) {
        emit(StoreState.success(success));
      },
      failure: (message) {
        emit(StoreState.error(message));
      },
    );
  }
}
