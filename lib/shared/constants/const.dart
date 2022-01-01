import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppy/layout/login/login_screen.dart';
import 'package:shoppy/shared/network/local/cache_helper.dart';

String getOs()
{
  return Platform.operatingSystem;
}

void navigateTo(context,widget)=>Navigator.push(
    context,
    MaterialPageRoute(builder: (context)=>widget)
);

void navigateToAndFinish(context,widget)=>Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context)=>widget),
        (route)
        {
          return false;
        }
);

void Logout (context){
  CacheHelper.RemoveData(key: 'token').then((value){
    if(value)
    {
      navigateToAndFinish(context, Login_Screen());
    }
  });
}