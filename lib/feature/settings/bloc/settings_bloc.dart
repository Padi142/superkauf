import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:superkauf/generic/settings/use_case/get_settings_use_case.dart';

import 'settings_state.dart';

part 'settings_event.dart';

class UserSettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetSettingsUseCase getSettingsUseCase;

  UserSettingsBloc({
    required this.getSettingsUseCase,
  }) : super(const SettingsState.loading()) {
    on<GetSettings>(_onGetSettings);
  }

  var userId = -1;

  Future<void> _onGetSettings(
    GetSettings event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsState.loading());
    final settings = await getSettingsUseCase.call();

    emit(SettingsState.loaded(settings));
  }
}
