import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../models/login_model.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit():super(RegisterInitialState());
  
  static RegisterCubit get(context)=>BlocProvider.of(context);


  LoginModel? loginModel;
  void register({
    required String name,
    required String email,
    required String password,
    required String phone,

  }){
    emit(RegisterLoadingState());
   DioHelper.postData(
       url: REGISTER,
       data: {
         "name": name,
         "email": email,
         "password": password,
         "phone" : phone,
       }
   ).then((value) {
loginModel=LoginModel(value.data);
emit(RegisterSuccessState(loginModel));
   }).catchError((error){
     print(error.toString());
     emit(RegisterErrorState());
   });
  }

  bool isVisible = true;
  var visibleIcon = Icons.visibility;
  void changePassVisibility() {
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
}