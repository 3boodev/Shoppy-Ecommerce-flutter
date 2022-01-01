import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shoppy/layout/login/login_screen.dart';
import 'package:shoppy/shared/constants/const.dart';
import 'package:shoppy/shared/network/local/cache_helper.dart';

import '../../main.dart';

class OnBoardingScreeen extends StatelessWidget{
   List pageInfos = [
    {
      "title": "Order Your Food",
      "body": "Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus."
          " Vestibulum ac diam sit amet quam vehicula elementum sed sit amet "
          "dui. Nulla porttitor accumsan tincidunt.",
      "img": "assets/onboarding_1.PNG",
    },
    {
      "title": "Fast Delivery",
      "body": "Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus."
          " Vestibulum ac diam sit amet quam vehicula elementum sed sit amet "
          "dui. Nulla porttitor accumsan tincidunt.",
      "img": "assets/onboarding_2.PNG",
    },
    {
      "title": "Easy Payment",
      "body": "Vivamus magna justo, lacinia eget consectetur sed, convallis at tellus."
          " Vestibulum ac diam sit amet quam vehicula elementum sed sit amet "
          "dui. Nulla porttitor accumsan tincidunt.",
      "img": "assets/onboarding_3.PNG",
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<PageViewModel> pages = [
      for(int i = 0; i<pageInfos.length; i++)
        _buildPageModel(pageInfos[i])
    ];
    void submit(){
      CacheHelper.saveData(key: 'onBoarding', value: true).then((value)
      {
        if(value){
          navigateToAndFinish(context,Login_Screen());
        }
      });
    }
    return Scaffold(
        appBar: AppBar(
         actions: [
           TextButton(child: Text('SKIP',style: TextStyle(color:  Colors.teal,fontWeight: FontWeight.bold,fontSize: 16),),
             onPressed: (){
              submit();
             },
           )
         ],
        ),
        body:IntroductionScreen(
            pages: pages,
            onDone: () {
             submit();
            },
            showSkipButton: false,
            showDoneButton: true,
            showNextButton: false,
            done:Container(child: Text('GET STARTED',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),color:  Colors.teal,alignment: Alignment.center,height: 50,),
            dotsDecorator: DotsDecorator(
              color: Colors.transparent,
              activeColor:  Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.teal)
              )
            ),
          ),
      );
  }
  _buildPageModel(Map item){
    return PageViewModel(
      title: item['title'],
      body: item['body'],
      image: Image.asset(
        item['img'],
        height:280,
      ),
      decoration: PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.w600,
          color:Colors.teal
        ),
        bodyTextStyle: TextStyle(fontSize: 16),
      ),
    );
  }
}