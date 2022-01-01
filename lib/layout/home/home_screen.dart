import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/layout/home/cubit/cubit.dart';
import 'package:shoppy/layout/home/cubit/states.dart';
import 'package:shoppy/layout/search/search_screen.dart';
import 'package:shoppy/shared/constants/const.dart';

class Home_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return  BlocProvider(
      create:(BuildContext context)=>HomeCubit()..getHomeData(),
      child: BlocConsumer<HomeCubit,HomeStates>(
            listener: (context,state){},
            builder: (context,state){
              var cubit=HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Shoppy'),
              actions: [
                IconButton(icon: Icon(Icons.search), onPressed: (){
                  navigateTo(context, Search_Screen());
                })
              ],
            ),
            body: cubit.bottomscreens[cubit.currentindex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index){
                cubit.ChangeBottom(index);
              },
              currentIndex: cubit.currentindex,
              selectedItemColor: Colors.teal,
              unselectedItemColor: Colors.black54,
              selectedLabelStyle:TextStyle(fontWeight: FontWeight.bold),
            items: [
                BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Categories'),
                BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favourites'),
                BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
              ],
          ),
          );
        }),
    );
  }
}
