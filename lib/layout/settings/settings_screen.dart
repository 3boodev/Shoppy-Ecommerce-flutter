import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/layout/home/cubit/cubit.dart';
import 'package:shoppy/layout/home/cubit/states.dart';
import 'package:shoppy/shared/components/components.dart';
import 'package:shoppy/shared/constants/const.dart';

class Setting_Screen extends StatelessWidget {
  var formkey =GlobalKey<FormState>();
  TextEditingController name_controller;
  TextEditingController email_controller;
  TextEditingController phone_controller;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state){
          /*if(state is SuccessGetUserState){
            name_controller.text=state.user_model.data.name;
            email_controller.text=state.user_model.data.email;
            phone_controller.text=state.user_model.data.phone;
          }*/
        },
        builder: (context,state){
          var user_model=HomeCubit.get(context).userModel;
          name_controller.text=user_model.data.name;
          email_controller.text=user_model.data.email;
          phone_controller.text=user_model.data.phone;
          return ConditionalBuilder(
            condition: HomeCubit.get(context).userModel!=null,
            builder: (context)=> Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    if(state is LoadingUpdateUserState)
                      LinearProgressIndicator(),
                    defaultFormField(
                      controller: name_controller,
                      type: TextInputType.name,
                      validate: (String value){
                        if(value.isEmpty){return 'Name Must be Not Empty';}
                        return null;
                      },
                      label: 'Name',
                      prefix: Icons.person,
                    ),
                    SizedBox(height: 15,),
                    defaultFormField(
                      controller: email_controller,
                      type: TextInputType.emailAddress,
                      validate: (String value){
                        if(value.isEmpty){return 'Email Must be Not Empty';}
                        return null;
                      },
                      label: 'Email',
                      prefix: Icons.email,
                    ),
                    SizedBox(height: 15,),
                    defaultFormField(
                      controller: phone_controller,
                      type: TextInputType.phone,
                      validate: (String value){
                        if(value.isEmpty){return 'Phone Must be Not Empty';}
                        return null;
                      },
                      label: 'Email',
                      prefix: Icons.phone_android,
                    ),
                    SizedBox(height: 15,),
                    defaultButton(
                        onpress:() {
                          if(formkey.currentState.validate())
                          {
                           HomeCubit.get(context).updateUserData
                             (name: name_controller.text, email: email_controller.text, phone: phone_controller.text);
                           defaultToast(msg:  HomeCubit.get(context).userModel.message.toString(), state: ToastStates.SUCCESS);
                          }
                          else{defaultToast(msg:  HomeCubit.get(context).userModel.message.toString(), state: ToastStates.ERROR);}
                        },
                        text: 'Update'
                    ),
                    SizedBox(height: 15,),
                    defaultButton(
                        onpress:() {
                          Logout(context);
                        },
                        text: 'Logout'
                    ),
                  ],
                ),
              ),
            ),
            fallback:(context)=>Center(child: CircularProgressIndicator()) ,
          );
        }
    );
  }

}
