import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/layout/categories/categories_screen.dart';
import 'package:shoppy/layout/favorites/favorites_screen.dart';
import 'package:shoppy/layout/home/cubit/states.dart';
import 'package:shoppy/layout/products/products_screen.dart';
import 'package:shoppy/layout/settings/settings_screen.dart';
import 'package:shoppy/models/categoriesmodel.dart';
import 'package:shoppy/models/change_favoritesmodel.dart';
import 'package:shoppy/models/favoritesmodel.dart';
import 'package:shoppy/models/homemodel.dart';
import 'package:shoppy/models/loginmodel.dart';
import 'package:shoppy/shared/components/components.dart';
import 'package:shoppy/shared/network/end_points.dart';
import 'package:shoppy/shared/network/remote/dio_helper.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() :super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentindex=0;

  List<Widget>bottomscreens=[
    Products_Screen(),
    Categories_Screen(),
    Favourites_Screen(),
    Setting_Screen(),
  ];

  void ChangeBottom(int index) {
    currentindex=index;
    emit(ChangeBottomNavState());
  }

  HomeModel homeModel;
  Map<int,bool>favorites={};
  void getHomeData(){
    emit(LoadingHomeDataState());
    DioHelper.getData(url: HOME,token: token).then((value) {
      homeModel=HomeModel.fromJson(value.data);
      homeModel.data.products.forEach((element) {
        favorites.addAll({
          element.id:element.inFavorites,
        });
      });
     /* printfulltext(homeModel.data.products[0].image.toString());
      printfulltext(homeModel.data.products[0].name);*/
    emit(SuccessHomeDataState());
    }).catchError((onError){
      print(onError.toString());
      emit(ErrorHomeDataState());});
  }


  CategoriesModel categoryModel;
  void getcategoryData(){
     DioHelper.getData(url: CATEGORIES).then((value) {
       categoryModel=CategoriesModel.fromJson(value.data);
      emit(SuccessCategoriesState());
    }).catchError((onError){
      print(onError.toString());
      emit(ErrorCategoriesState());});
  }


  ChangeFavoritesModel changefavoritesModel;
  void changeFavorite(int productId){
    favorites[productId]=!favorites[productId];
    emit(SuccesschangeFavoritesState());
    DioHelper.postData(url: FAVORITES,
        data: {
         'product_id':productId
         },
       token: token).then((value) {
      changefavoritesModel=ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if(!favoritesModel.status){favorites[productId]=!favorites[productId];}
      else{getfavoritesData();}
      emit(SuccessFavoritesState(changefavoritesModel));
    }).catchError((onError){
      favorites[productId]=!favorites[productId];
      emit(ErrorFavoritesState());
    });
  }

  FavoritesModel favoritesModel;
  void getfavoritesData(){
    emit(LoadingGetFavoritesState());
    DioHelper.getData(url: FAVORITES,token: token).then((value) {
      favoritesModel=FavoritesModel.fromJson(value.data);
      emit(SuccessGetFavoritesState());
    }).catchError((onError){
      print(onError.toString());
      emit(ErrorGetFavoritesState());});
  }

  LoginModel userModel;
  void getUserData(){
    emit(LoadingGetUserState());
    DioHelper.getData(url: PROFILE,token: token).then((value) {
      userModel=LoginModel.fromJson(value.data);
      print(userModel.data.name);
      emit(SuccessGetUserState(userModel));
    }).catchError((onError){
      print(onError.toString());
      emit(ErrorGetUserState());});
  }

  void updateUserData({
  @required String name ,
  @required String email ,
  @required String phone ,
}){
    emit(LoadingUpdateUserState());
    DioHelper.putData(url: UPDATE,token: token,data: {'name':name,'email':email,'phone':phone}).then((value) {
      userModel=LoginModel.fromJson(value.data);
      print(userModel.data.name);
      emit(SuccessUpdateUserState(userModel));
    }).catchError((onError){
      print(onError.toString());
      emit(ErrorUpdateUserState());});
  }
}