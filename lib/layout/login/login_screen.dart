import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoppy/layout/home/home_screen.dart';
import 'package:shoppy/layout/register/register_screen.dart';
import 'package:shoppy/shared/network/local/cache_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'package:shoppy/shared/components/components.dart';
import 'package:shoppy/shared/constants/const.dart';

class Login_Screen extends StatelessWidget {
var formkey =GlobalKey<FormState>();
var email_controller=TextEditingController();
var password_controller=TextEditingController();
  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create:(BuildContext context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,dynamic>(
        listener: (context,state){
          if(state is LoginSuccessState)
          {
            if(state.loginModel.status)
              {
                print(state.loginModel.message);
                print(state.loginModel.data.token);
                CacheHelper.saveData(key: 'token', value: state.loginModel.data.token).then((value){
                  token=state.loginModel.data.token;
                  navigateToAndFinish(context, Home_Screen());
                  defaultToast(msg: state.loginModel.message.toString(), state: ToastStates.SUCCESS);
                });

              }else{
              print(state.loginModel.message);
              defaultToast(msg: state.loginModel.message.toString(), state: ToastStates.ERROR);
            }
          }
        },
        builder: (BuildContext context, state)
        {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Login',style: TextStyle(color: Colors.teal,fontWeight: FontWeight.bold,fontSize: 30)),
                        SizedBox(height: 5,),
                        Text('Login and Enjoy by Our Awesome Offers.',style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 14)),
                        SizedBox(height: 20,),
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
                            suffix:LoginCubit.get(context).Sofix ,
                            isPassword: LoginCubit.get(context).ispassowrd,
                            suffixpressed: (){
                              LoginCubit.get(context).ChangePasswordVisibility();
                            },
                     /*     onSubmit: (value){
                            if(formkey.currentState.validate())
                            {
                              LoginCubit.get(context).userlogin(
                                  email: email_controller.text,
                                  password: password_controller.text
                              );
                            }
                          },*/
                        ),
                        SizedBox(height: 30,),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context)=>defaultButton(
                            onpress: (){
                              if(formkey.currentState.validate())
                              {
                                LoginCubit.get(context).userlogin(
                                    email: email_controller.text,
                                    password: password_controller.text
                                );
                              }
                            },
                            text: 'Login',
                            radius: 10,
                            isuppercase: true
                          ),
                          fallback:(context)=>Center(child: CircularProgressIndicator()) ,
                        ),
                        SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?' ,style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 14)),
                            defaultTextButton(
                                function: ()=>{
                                  navigateToAndFinish(context, Register_Screen())
                                },
                                text: 'Register')
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

