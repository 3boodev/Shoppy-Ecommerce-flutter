import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/layout/home/home_screen.dart';
import 'package:shoppy/layout/login/login_screen.dart';
import 'package:shoppy/layout/register/cubit/cubit.dart';
import 'package:shoppy/layout/register/cubit/states.dart';
import 'package:shoppy/shared/components/components.dart';
import 'package:shoppy/shared/constants/const.dart';
import 'package:shoppy/shared/network/local/cache_helper.dart';

class Register_Screen extends StatelessWidget {
  var formkey =GlobalKey<FormState>();

  var name_controller=TextEditingController();
  var email_controller=TextEditingController();
  var password_controller=TextEditingController();
  var phone_controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:(BuildContext context)=>RegisterCubit(),
    child: BlocConsumer<RegisterCubit,RegisterStates>(
    listener: (context,state){
    if(state is RegisterSuccessState)
    {
    if(state.registerModel.status)
    {
    print(state.registerModel.message);
    print(state.registerModel.data.token);
    CacheHelper.saveData(key: 'token', value: state.registerModel.data.token).then((value){
    token=state.registerModel.data.token;
    navigateToAndFinish(context, Home_Screen());
    defaultToast(msg: state.registerModel.message.toString(), state: ToastStates.SUCCESS);
    });

    }else{
    print(state.registerModel.message);
    defaultToast(msg: state.registerModel.message.toString(), state: ToastStates.ERROR);
    }
    }
    },
    builder: (BuildContext context, state)
    {
      return Scaffold(
          appBar: AppBar(
          ),
          body: Center(
          child: SingleChildScrollView(
          child: Padding(
          padding: const EdgeInsets.all(20),
      child: Form(
        key: formkey,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text('Register',style: TextStyle(color: Colors.teal,fontWeight: FontWeight.bold,fontSize: 30)),
    SizedBox(height: 5,),
    Text('Register and Enjoy by Our Awesome Offers.',style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 14)),
                  SizedBox(height: 20,),
                  defaultFormField(
                      controller: name_controller,
                      type: TextInputType.name,
                      validate: (String value){
                        if(value.isEmpty){
                          return 'Full Name Must be more than 8 characters';
                        }
                      },
                      label: 'Full Name',
                      prefix: Icons.person
                  ),
                  SizedBox(height: 10,),
                  defaultFormField(
                      controller: email_controller,
                      type: TextInputType.emailAddress,
                      validate: (String value){
                        if(value.isEmpty){
                          return 'Email Must be Correct';
                        }
                      },
                      label: 'Email Address',
                      prefix: Icons.email_outlined
                  ),
                  SizedBox(height: 10,),
                  defaultFormField(
                    controller: password_controller,
                    type: TextInputType.visiblePassword,
                    validate: (String value){
                      if(value.isEmpty){
                        return 'Password Must be Correct';
                      }
                    },
                    label: 'Password',
                    prefix: Icons.lock_outline,
                    suffix: RegisterCubit.get(context).Sofix,
                    isPassword: RegisterCubit.get(context).ispassowrd,
                    suffixpressed: (){
                      RegisterCubit.get(context).ChangeRegisterPasswordVisibility();
                    },
                  ),

                  SizedBox(height: 10,),
                  defaultFormField(
                    controller: phone_controller,
                    type: TextInputType.phone,
                    validate: (String value){
                      if(value.isEmpty){
                        return 'Phone Must be Correct as 11 Numbers';
                      }
                    },
                    label: 'Phone',
                    prefix: Icons.phone,
                    isPassword: false,
                  ),
                  SizedBox(height: 30,),
                  ConditionalBuilder(
                    condition: state is! RegisterLoadingState,
                    builder: (context)=>defaultButton(
                        onpress: (){
                          if(formkey.currentState.validate())
                          {
                            RegisterCubit.get(context).user_register(
                                name: name_controller.text,
                                email: email_controller.text,
                                password: password_controller.text,
                                phone: phone_controller.text
                            );
                          }
                        },
                        text: 'Register',
                        radius: 10,
                        isuppercase: true
                    ),
                    fallback:(context)=>Center(child: CircularProgressIndicator()) ,
                  ),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('I have an account?' ,style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 14)),
                      defaultTextButton(
                        function: ()=>{
                          navigateToAndFinish(context, Login_Screen())
                        }, text: 'Login')
                    ],
                  ),
                ],
              ),
      ),
          ),
        ),
      ),
    );
  }
  ));
  }
}
