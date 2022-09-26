import 'package:shop_app/models/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class ChangePassVisibilityState extends LoginStates{}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {

  LoginModel loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends LoginStates {
  String error;
  LoginErrorState({required this.error});
}
