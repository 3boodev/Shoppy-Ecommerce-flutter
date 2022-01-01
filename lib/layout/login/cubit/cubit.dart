import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/layout/login/cubit/states.dart';
import 'package:shoppy/models/loginmodel.dart';
import 'package:shoppy/shared/network/end_points.dart';
import 'package:shoppy/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit():super(LoginInitialState());
  static LoginCubit get(context)=>BlocProvider.of(context);
  LoginModel loginModel;
  void userlogin({
  @required String email,
  @required String password,
}) {
    emit(LoginLoadingState());
    DioHelper.postData(
       url: LOGIN,
       data: {
         'email':email,
         'password':password,
       },
       ).then((value){
          print(value.data);
          loginModel=LoginModel.fromJson(value.data);
          print(loginModel.message);
          emit(LoginSuccessState(loginModel));
       }).catchError((onError){
         print(onError.toString());
         emit(LoginErrorState(onError.toString()));
   });
  }

  IconData Sofix =Icons.visibility;
  bool ispassowrd=true;

  void ChangePasswordVisibility(){
    ispassowrd=!ispassowrd;
    Sofix =ispassowrd?Icons.visibility:Icons.visibility_off;
    emit(ChangePasswordVisibilityState());
  }


}