import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:superkauf/generic/user/use_case/get_current_user_use_case.dart';

import '../use_case/init_navigation.dart';
import 'init_state.dart';

part 'init_event.dart';

class InitBloc extends Bloc<InitEvent, InitState> {
  InitNavigation initNavigation;
  GetCurrentUserUseCase getCurrentUserUseCase;

  InitBloc({
    required this.initNavigation,
    required this.getCurrentUserUseCase,
  }) : super(const InitState.loading()) {
    on<InitApplication>(_onInitApplication);
  }

  Future<void> _onInitApplication(
    InitApplication event,
    Emitter<InitState> emit,
  ) async {
    emit(const InitState.loading());
    initNavigation.goToHome();

    final user = await getCurrentUserUseCase.call();

    if (user != null) {
      Posthog().identify(userId: user.id.toString(), properties: {"username": user.username, "supabase_uid": user.supabaseUid});
      OneSignal.login(user.supabaseUid);
    } else {
      Posthog().capture(eventName: 'anonymous_session');
    }
  }
}
