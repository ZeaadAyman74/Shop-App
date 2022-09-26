import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/states.dart';

import '../network/local/cache_helper.dart';


class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() :super(InitialState());

  static ShopCubit get(BuildContext context) => BlocProvider.of(context);

  bool isDark = true;

  void changeMode({bool? isDark}) {
    if (isDark != null) {
      this.isDark = isDark;
      emit(ChangeModeSuccessState());
      }else{
        CacheHelper.putData(key:'isDark', value: !this.isDark).then((value) {
          this.isDark=!this.isDark;
          emit(ChangeModeSuccessState());
        }).catchError((error){
          emit(ChangeModeErrorState());
        });

      }

    }
  }
