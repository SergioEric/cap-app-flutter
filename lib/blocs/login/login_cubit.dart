import 'package:bloc/bloc.dart';
import 'package:cap_sahagun/models/auth/auth.model.dart';
import 'package:cap_sahagun/providers/login_repository/login.repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meta/meta.dart';

import '../../global.providers.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    @required LoginRepository repository,
    @required Reader read,
  })  : assert(
          read != null && repository != null,
          "LoginRepository and Reader must be not null, LoginCubit",
        ),
        _read = read,
        _repository = repository,
        super(
          LoginInitial(),
        );

  final LoginRepository _repository;
  final Reader _read;

  getLogIn({
    @required String email,
    @required String password,
  }) async {
    emit(LoginInProgress());
    // await Future.delayed(Duration(milliseconds: 2200));
    try {
      Auth user = await _repository.getLogin(
        email: email,
        password: password,
      );
      if (user != null) {
        emit(LoginSuccess(auth: user));
        _read(authProvider).state = true;
      }
    } catch (e) {
      emit(LoginError(error: e.toString()));
    }
  }
}
