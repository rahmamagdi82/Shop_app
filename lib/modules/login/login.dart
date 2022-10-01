import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home.dart';
import 'package:shop_app/modules/login/login_cubit/cubit.dart';
import 'package:shop_app/modules/login/login_cubit/states.dart';
import 'package:shop_app/modules/register/register.dart';
import 'package:shop_app/shared/components/comonents.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';

import '../../shared/components/cubit/cubit.dart';

class Login extends StatelessWidget
{
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (BuildContext context, state) {
          if(state is LoginSuccessState){
            if(state.loginModel.status){
              CashHelper.putData(key: 'token', value: state.loginModel.data.token).then((value) {
                token=state.loginModel.data.token;
                ShopCubit.get(context).getUser();
                ShopCubit.get(context).getHome();
                ShopCubit.get(context).getFavorite();
                navigationAndFinish(context, Home());
              });
            }else
              {
                toast(
                    message: state.loginModel.message,
                color: Colors.red,
                );
              }
          }
        },
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            appBar: AppBar(),
            body:Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key:formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 30.0,),
                        defultTextFormFeild(
                          validate: (value){
                            if(value!.isEmpty){
                              return 'email must be not null';
                            }else
                            {
                              return null;
                            }
                          },
                          control: emailController,
                          type: TextInputType.emailAddress,
                          lable: 'Email Address',
                          prefix: Icons.email,
                        ),
                        const SizedBox(height: 15.0,),
                        defultTextFormFeild(
                          validate: (value){
                            if(value!.isEmpty){
                              return 'password must be not null';
                            }else
                            {
                              return null;
                            }
                          },
                          control: passwordController,
                          type: TextInputType.visiblePassword,
                          lable: 'Password',
                          prefix: Icons.lock,
                          suffix: LoginCubit.get(context).icon,
                          submit: (value){
                            if(formKey.currentState!.validate()){
                              LoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                            },
                          obscure: LoginCubit.get(context).obsecure,
                          show: (){
                            LoginCubit.get(context).changeShowPassword();
                          },
                        ),
                        const SizedBox(height: 30.0,),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder:(context)=> defultButton(
                            uperCase: true,
                            function: (){
                              if(formKey.currentState!.validate()){
                                LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }

                              //navigation(context, widget),
                            },
                            text: 'login',
                          ),
                          fallback:(context)=> const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(height: 15.0,),
                        Row(
                          children: [
                            const Text("Don't have an account?"),
                            defultTextButton(
                                function: (){
                                  navigation(context, Register());
                                }, text: 'register'),
                          ],
                        )
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