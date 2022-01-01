import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/layout/register/cubit/states.dart';
import 'package:shoppy/models/loginmodel.dart';
import 'package:shoppy/models/registermodel.dart';
import 'package:shoppy/shared/network/end_points.dart';
import 'package:shoppy/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit():super(RegisterInitialState());
  static RegisterCubit get(context)=>BlocProvider.of(context);
  RegisterModel registerModel;
  void user_register({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name':name,
        'email':email,
        'password':password,
        'phone':phone
      },
    ).then((value){
      print(value.data);
      registerModel=RegisterModel.fromJson(value.data);
      print(registerModel.message);
      emit(RegisterSuccessState(registerModel));
    }).catchError((onError){
      print(onError.toString());
      emit(RegisterErrorState(onError.toString()));
    });
  }

  IconData Sofix =Icons.visibility;
  bool ispassowrd=true;

  void ChangeRegisterPasswordVisibility(){
    ispassowrd=!ispassowrd;
    Sofix =ispassowrd?Icons.visibility:Icons.visibility_off;
    emit(ChangeRegiserPasswordVisibilityState());
  }


}