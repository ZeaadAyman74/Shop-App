import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_cubit/layout_states.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import '../../models/login_model.dart';
import '../../modules/favorites/favorites_screen.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(InitialState());

  static LayoutCubit get(BuildContext context) => BlocProvider.of(context);

  List<Map<String,Widget>> bottomScreens = [
    {
      'page':const ProductsScreen(),
      'title': const Text("Home",style: TextStyle(fontSize: 30),)
    },
    {
      'page':const CategoriesScreen(),
      'title': const Text("Categories",style: TextStyle(fontSize: 30),)
    },
    {
      'page':const FavoritesScreen(),
      'title': const Text("Favorites",style: TextStyle(fontSize: 30),)
    },
    {
      'page':  const SettingsScreen(),
      'title': const Text("Settings",style: TextStyle(fontSize: 30),)
    },
  ];

  int currentIndex = 0;

  void changeBottomScreen(int index) {
    currentIndex = index;
    emit(ChangeBottomScreenSuccess());
  }

  HomeModel? homeModel;

  void getHomeData() {
    emit(GetHomeDataLoadingState());
    DioHelper.getData(path: HOME, query: null, token: token).then((value) {
      homeModel = HomeModel(value.data);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorites});
      });
      emit(GetHomeDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetHomeDataErrorState());
    });
  }

  CategoryModel? categoryModel;

  void getCategoryData() {
    emit(GetCategoryDataLoadingState());
    DioHelper.getData(path: CATEGORY, query: null, token: token).then((value) {
      categoryModel = CategoryModel(value.data);
      emit(GetCategoryDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetHomeDataErrorState());
    });
  }

  Map<int, bool> favorites = {};
  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(PriorityChangeFavoritesSuccessState());

    DioHelper.postData(
            url: FAVORITES, data: {"product_id": productId}, token: token)
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel(value.data);

      if (!changeFavoritesModel!.status) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavoritesData();
      }
      emit(ChangeFavoritesSuccessState());
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ChangeFavoritesErrorState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavoritesData() {
    emit(GetFavoritesDataLoadingState());

    DioHelper.getData(path: FAVORITES, query: null, token: token).then((value) {
      favoritesModel = FavoritesModel(value.data);
      emit(GetFavoritesDataSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetFavoritesDataError());
    });
  }

  LoginModel?
      userModel; // استخدمت نفس ال model بتاع ال login عشان ال profile  وال login بيرجعوا نفس ال response
  void getUser() {
    emit(GetUserDataLoading());
    DioHelper.getData(path: PROFILE, query: null, token: token).then((value) {
      userModel = LoginModel(value.data);
      print(value.data);
      emit(GetUserDataSuccess(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(GetUserDataError());
    });
  }

//هنا انا هعدل على نفس ال userModel اللي موجود عشان هي نفس الداتا اللي ظاهرة عندي
  void updateProfile({
    required String name,
    required String email,
    required String phone,
}) {
    emit(UpdateUserLoading());
    DioHelper.putData(
        token: token,
        path: UPDATE,
        name:name ,
        email: email,
        phone: phone,
    ).then((value){
      userModel=LoginModel(value.data);
      emit(UpdateUserDataSuccess());
    }).catchError((error){
      emit(UpdateUserDataError());
    });
  }
}
