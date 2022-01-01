import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/layout/home/cubit/cubit.dart';
import 'package:shoppy/layout/home/cubit/states.dart';
import 'package:shoppy/models/categoriesmodel.dart';

class Categories_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => CatItem(HomeCubit.get(context).categoryModel.data.data[index]),
            separatorBuilder: (context, index) => SizedBox(width: 10,),
            itemCount: HomeCubit.get(context).categoryModel.data.data.length,
          );
        }
    );
  }
  Widget CatItem(Datum model)=>Padding(
    padding: const EdgeInsets.all(20),
    child: Row(
      children: [
        Image(
          image: NetworkImage(model.image),
          width:100,
          height:100,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 20,),
        Text('${model.name}',style: TextStyle(color: Colors.black,fontSize: 20),),
        Spacer(),
        Icon(Icons.arrow_forward_ios)
      ],
    ),
  );
}
