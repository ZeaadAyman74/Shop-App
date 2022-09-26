import 'package:shop_app/models/login_model.dart';

class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  LoginModel? loginModel;
  RegisterSuccessState(this.loginModel);
}

class RegisterErrorState extends RegisterStates {}

class ChangePassVisibilityState extends RegisterStates {}