import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/layout/home/cubit/cubit.dart';
import 'package:shoppy/layout/home/cubit/states.dart';
import 'package:shoppy/shared/components/components.dart';

class Favourites_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){},
        builder: (context,state){
          return ConditionalBuilder(
            condition: state is!LoadingGetFavoritesState,
            builder: (context)=>ListView.separated(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context,index)=>BuildListProuduct(HomeCubit.get(context).favoritesModel.data.data[index],context),
              separatorBuilder:(context,index)=> SizedBox(width: 10,),
              itemCount: HomeCubit.get(context).favoritesModel.data.data.length,
            ),
            fallback:(context)=>Center(child: CircularProgressIndicator()) ,
          );
    });
  }


}
