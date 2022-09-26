import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  bool isVisible = true;
  var visibleIcon = Icons.visibility;
  dynamic changePassVisibility() {
    if (isVisible == true) {
      visibleIcon = Icons.visibility_off;
      isVisible = false;
      emit(ChangePassVisibilityState());
    } else {
      visibleIcon = Icons.visibility;
      isVisible = true;
      emit(ChangePassVisibilityState());
    }
  }

  late LoginModel loginModel;
  void loginUser({required String email, required String password}) async {
    emit(LoginLoadingState());
     DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value){
      loginModel=LoginModel(value.data);
      emit(LoginSuccessState(loginModel));
     }).catchError((error){
       emit(LoginErrorState(error: error));
     });
  }
}
