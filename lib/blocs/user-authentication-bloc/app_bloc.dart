import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/repository/authentication_repository/authentication_repository.dart';
import '../../repository/models/user_model.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(authenticationRepository.currentUser != null
            ? AppState.authenticated(authenticationRepository.currentUser)
            : const AppState.unauthenticated()) {
    on<AppEvent>((event, emit) {
      on<AppUserChangeEvent>(_onAppUserChange);
      on<AppLogOutEvent>(_onLogOut);
      _userSubscription = _authenticationRepository.user.listen((user) {
        add(
          AppUserChangeEvent(user),
        );
      });
    });
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;

  FutureOr<void> _onAppUserChange(
      AppUserChangeEvent event, Emitter<AppState> emit) {
    emit(event.user.isNotEmpty ? AppState.authenticated(event.user) : const AppState.unauthenticated() );
  }

  FutureOr<void> _onLogOut(AppLogOutEvent event, Emitter<AppState> emit) {}
}
