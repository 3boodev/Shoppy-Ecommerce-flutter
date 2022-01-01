import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/layout/search/cubit/cubit.dart';
import 'package:shoppy/layout/search/cubit/states.dart';
import 'package:shoppy/models/searchmodel.dart';
import 'package:shoppy/shared/components/components.dart';

class Search_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  var formkey =GlobalKey<FormState>();
  var searchvontroller=TextEditingController();

    return BlocProvider(
    create:(BuildContext context)=>SearchCubit(),
    child: BlocConsumer<SearchCubit,SearchStates>(
    listener: (context,state){},
    builder: (context,state) {
      return Scaffold(
        appBar: AppBar(),
        body:Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                 defaultFormField(
                     controller: searchvontroller,
                     type: TextInputType.text,
                     validate: (String value){
                       if(value.isEmpty)
                         {
                           return'Error Text to Search';
                         }
                     },
                   onSubmit: (String text){
                       SearchCubit.get(context).search(text);
                   },
                     label: 'Enter Item You Want Find',
                     prefix: Icons.location_searching,
                 ),
                SizedBox(height: 10,),
                if(state is SearchLoadingState)
                  LinearProgressIndicator(),
                SizedBox(height: 10,),
                if(state is SearchSuccessState)
                  Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context,index)=>BuildListProuduct(SearchCubit.get(context).model.data.data[index],context,isoldprice: false),
                      separatorBuilder:(context,index)=> SizedBox(width: 10,),
                      itemCount: SearchCubit.get(context).model.data.data.length,
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    }
    ),
    );
  }
}
