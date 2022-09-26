import '../../models/login_model.dart';

abstract class LayoutStates {}

class InitialState extends LayoutStates{}

class ChangeBottomScreenSuccess extends LayoutStates{}

class ChangeBottomScreenError extends LayoutStates{}

class GetHomeDataLoadingState extends LayoutStates {}

class GetHomeDataErrorState extends LayoutStates {}

class GetHomeDataSuccessState extends LayoutStates {}

class GetCategoryDataLoadingState extends LayoutStates {}

class GetCategoryDataErrorState extends LayoutStates {}

class GetCategoryDataSuccessState extends LayoutStates {}

class ChangeFavoritesSuccessState extends LayoutStates {}

class PriorityChangeFavoritesSuccessState extends LayoutStates {}

class ChangeFavoritesErrorState extends LayoutStates {}

class GetFavoritesDataLoadingState extends LayoutStates {}

class GetFavoritesDataSuccess extends LayoutStates {}

class GetFavoritesDataError extends LayoutStates {}

class GetUserDataLoading extends LayoutStates {}

class GetUserDataSuccess extends LayoutStates {
  LoginModel? userModel;
  GetUserDataSuccess(this.userModel);
}

class GetUserDataError extends LayoutStates {}

class UpdateUserLoading extends LayoutStates {}

class UpdateUserDataSuccess extends LayoutStates {}

class UpdateUserDataError extends LayoutStates {}