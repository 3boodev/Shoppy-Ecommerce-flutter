import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/layout/home/cubit/cubit.dart';
import 'package:shoppy/layout/home/cubit/states.dart';
import 'package:shoppy/models/categoriesmodel.dart';
import 'package:shoppy/models/homemodel.dart';
import 'package:shoppy/shared/components/components.dart';

class Products_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context)
  {
    return  BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){
          if(state is SuccessFavoritesState){
            if(!state.model.status){
              defaultToast(msg: '${state.model.message}', state: ToastStates.ERROR);
            }
          }
        },
        builder: (context,state){
          return ConditionalBuilder(
            condition: HomeCubit.get(context).homeModel!=null&&HomeCubit.get(context).categoryModel!=null,
            builder: (context)=>ProductsBulder(HomeCubit.get(context).homeModel,HomeCubit.get(context).categoryModel,context),
            fallback:(context)=>Center(child: CircularProgressIndicator()) ,
          );
        }
    );
  }
  Widget ProductsBulder(HomeModel model,CategoriesModel ctmodel,context)=>SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment:CrossAxisAlignment.start ,
      children:
      [
        CarouselSlider(
          items: model.data.banners.map((e) =>
              Image(
                image: NetworkImage('${e.image}'),
                width:double.infinity,
                fit: BoxFit.cover,
              )
          ).toList(),
          options: CarouselOptions(
            height: 220,
            initialPage: 0,
            viewportFraction: 1,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          ),),
        SizedBox(height: 10,),
        Text('  CATEGORIES ',overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,),),
        SizedBox(height: 10,),
        Padding(
           padding: const EdgeInsets.symmetric(horizontal: 10),
           child: Container(
             height: 100,
             child: ListView.separated(
               scrollDirection: Axis.horizontal,
                 physics: BouncingScrollPhysics(),
                 itemBuilder: (context,index)=>CategoryItem(ctmodel.data.data[index]),
                 separatorBuilder:(context,index)=> SizedBox(width: 10,),
                 itemCount: ctmodel.data.data.length,
             ),
           ),
         ),
        SizedBox(height: 20,),
        Text('  New Products ',overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,),),
        Container(
          color: Colors.grey[900],
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
            childAspectRatio: 1/1.6,
            children: List.generate(model.data.products.length,
                    (index) =>GridProducts(model.data.products[index],context)),
          ),
        )
      ],
    ),
  );
  Widget CategoryItem(Datum cmodel)=>Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image: NetworkImage('https://student.valuxapps.com/storage/uploads/categories/16301438353uCFh.29118.jpg'),/*cmodel.image*/
        width:100,
        height:100,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(0.8),
        width: 100,
        child: Text('${cmodel.name}',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center,),
      ),
    ],);
  Widget GridProducts(Product model,context)=> Container(
    color: Colors.white,
    child: Column(
      children: [
       Stack(
         alignment: AlignmentDirectional.bottomStart,
         children: [
           Image(
             image: NetworkImage('${model.image}'),
             width:double.infinity,
             height: 200,
           ),
           if(model.discount!=0)
             Container(
             color: Colors.red,
             padding: EdgeInsets.symmetric(horizontal: 5),
             child: Text(
               'DISCOUNT'
                   ,style: TextStyle(fontSize: 10,color: Colors.white),
             ),
           )
         ],
       ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Text('${model.name}  ',maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(height: 1.1,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
              SizedBox(height: 5,),
              Row(children: [
                Text('${model.price.round()}\$  ',style: TextStyle(fontSize: 16,height: 1.1,fontWeight: FontWeight.bold,color:Colors.green[700] ),textAlign: TextAlign.center,),
                if(model.discount!=0)
                 Text('${model.oldPrice.round()}\$',style: TextStyle(fontSize: 12,height: 1.1,fontWeight: FontWeight.bold,color:Colors.grey,decoration: TextDecoration.lineThrough ),textAlign: TextAlign.center,),
                Spacer(),
                IconButton(
                    icon:  CircleAvatar(
                      radius: 20,
                      backgroundColor: HomeCubit.get(context).favorites[model.id]? Colors.red: Colors.grey,
                    child:Icon(Icons.favorite_border,color: Colors.white,),
                    ),
                    padding:EdgeInsets.zero,iconSize: 20,
                    onPressed:(){
                      HomeCubit.get(context).changeFavorite(model.id);
                    },
                ),
              ],mainAxisAlignment: MainAxisAlignment.center,),
            ],
          ),
        )

      ],
    ),
  );
}
