import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../repository/authentication_repository/authentication_repository.dart';
import '../../repository/validators/formz_validators.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authenticationRepository) : super(const SignUpState());

  final AuthenticationRepository _authenticationRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid:
        Formz.validate([email, state.password]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        isValid:
        Formz.validate([password, state.email]),
      ),
    );
  }


  Future onSignUp() async {
    if (!state.isValid) return;
    emit(
      state.copyWith(status: FormzSubmissionStatus.inProgress),
    );
    try {
      await _authenticationRepository.signUpWithEmailAndPassword(
          email: state.email.value, password: state.password.value);
      emit(
        state.copyWith(status: FormzSubmissionStatus.success),
      );
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
            status: FormzSubmissionStatus.failure, errorMessage: e.message),
      );
    } catch (e) {
      emit(
        state.copyWith(status: FormzSubmissionStatus.failure),
      );
    }
  }
}