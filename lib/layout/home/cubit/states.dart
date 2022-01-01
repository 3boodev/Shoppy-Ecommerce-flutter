
import 'package:shoppy/models/change_favoritesmodel.dart';
import 'package:shoppy/models/loginmodel.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class ChangeBottomNavState extends HomeStates {}
class LoadingHomeDataState extends HomeStates {}
class SuccessHomeDataState extends HomeStates {}
class ErrorHomeDataState extends HomeStates {}

class SuccessCategoriesState extends HomeStates {}
class ErrorCategoriesState extends HomeStates {}

class SuccessFavoritesState extends HomeStates {
  final ChangeFavoritesModel model;
  SuccessFavoritesState(this.model);
}
class SuccesschangeFavoritesState extends HomeStates {}
class ErrorFavoritesState extends HomeStates {}

class LoadingGetFavoritesState extends HomeStates {}
class SuccessGetFavoritesState extends HomeStates {}
class ErrorGetFavoritesState extends HomeStates {}

class LoadingGetUserState extends HomeStates {}
class SuccessGetUserState extends HomeStates {
  final LoginModel user_model;
  SuccessGetUserState(this.user_model);
}
class ErrorGetUserState extends HomeStates{}

class LoadingUpdateUserState extends HomeStates {}
class SuccessUpdateUserState extends HomeStates {
  final LoginModel user_model;
  SuccessUpdateUserState(this.user_model);
}
class ErrorUpdateUserState extends HomeStates{}