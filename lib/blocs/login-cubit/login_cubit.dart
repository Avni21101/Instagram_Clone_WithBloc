import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../repository/authentication_repository/authentication_repository.dart';
import '../../repository/validators/formz_validators.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository) : super(const LoginState());

  final AuthenticationRepository _authenticationRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
          email: email, isValid: Formz.validate([email, state.password])),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.email, password]),
      ),
    );
  }

  Future<void> onLogin() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _authenticationRepository.loginWithEmailAndPassword(
          email: state.email.value, password: state.password.value);
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(state.copyWith(
          errorMessage: e.message, status: FormzSubmissionStatus.failure));
    }
  }
}
