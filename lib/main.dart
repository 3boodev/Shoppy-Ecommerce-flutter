import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/layout/home/cubit/cubit.dart';
import 'package:shoppy/layout/home/home_screen.dart';
import 'package:shoppy/layout/login/cubit/cubit.dart';
import 'package:shoppy/layout/login/cubit/states.dart';
import 'package:shoppy/layout/login/login_screen.dart';
import 'package:shoppy/shared/bloc_observer.dart';
import 'package:shoppy/shared/components/components.dart';
import 'package:shoppy/shared/network/local/cache_helper.dart';
import 'package:shoppy/shared/network/remote/dio_helper.dart';
import 'layout/onboarding/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;

  bool onBoarding=CacheHelper.getData(key: 'onBoarding');
  token=CacheHelper.getData(key: 'token');

  if(onBoarding!=null)
    {
      if(token!=null)widget=Home_Screen();
      else widget=Login_Screen();
    }else widget=OnBoardingScreeen();
   runApp(MyApp(startwidget: widget,));
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final Widget startwidget;
  MyApp({this.startwidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers:
    [
      BlocProvider(create: (BuildContext conext)=>LoginCubit(),),
      BlocProvider(create: (BuildContext conext)=>HomeCubit()..getHomeData()..getcategoryData()..getfavoritesData()..getUserData(),)
    ],
        child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state){},
          builder:(context,state){
            return MaterialApp(
              title: 'Shoppy',
              theme: ThemeData(
                appBarTheme: AppBarTheme(
                  backwardsCompatibility: false,
                  //Control the top bar of ststus system
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.tealAccent,
                    statusBarBrightness: Brightness.light,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  elevation: 0,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                scaffoldBackgroundColor: Colors.white,
                primarySwatch: Colors.teal,
              ),
              debugShowCheckedModeBanner: false,
              home:startwidget,
            );
          } ,
        ));
  }
}

