import 'package:bloc/bloc.dart';
import 'package:cap_sahagun/models/auth/auth.model.dart';
import 'package:cap_sahagun/providers/login_provider/login.provider.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({this.repository}) : super(LoginInitial());

  final LoginRepository repository;

  getLogIn() async {
    emit(LoginInProgress());
    await Future.delayed(Duration(milliseconds: 2200));
    try {
      Auth user = await repository.getLogin(
        email: "null",
        password: "null",
      );
      if (user != null) {
        emit(LoginSuccess(auth: user));
      }
    } catch (e) {
      emit(LoginError(error: e.toString()));
    }
  }
}
