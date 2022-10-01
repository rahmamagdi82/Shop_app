import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home.dart';
import 'package:shop_app/shared/components/comonents.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';

import '../../shared/components/cubit/cubit.dart';
import 'register_cubit/cubit.dart';
import 'register_cubit/states.dart';

class Register extends StatelessWidget
{
  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (BuildContext context, state) {
          if(state is RegisterSuccessState){
            if(state.RegisterModel.status){
              CashHelper.putData(key: 'token', value: state.RegisterModel.data.token).then((value) {
                token=state.RegisterModel.data.token;
                ShopCubit.get(context).getUser();
                ShopCubit.get(context).getHome();
                ShopCubit.get(context).getFavorite();
                navigationAndFinish(context, Home());
              });
            }else
            {
              print(state.RegisterModel.message);
              toast(
                message: state.RegisterModel.message,
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
                          'Register',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 30.0,),
                        defultTextFormFeild(
                          validate: (value){
                            if(value!.isEmpty){
                              return 'please enter your name';
                            }else
                            {
                              return null;
                            }
                          },
                          control: nameController,
                          type: TextInputType.name,
                          lable: 'User Name',
                          prefix: Icons.person,
                        ),
                        const SizedBox(height: 15.0,),
                        defultTextFormFeild(
                          validate: (value){
                            if(value!.isEmpty){
                              return 'please enter your email';
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
                              return 'please enter your password';
                            }else
                            {
                              return null;
                            }
                          },
                          control: passwordController,
                          type: TextInputType.visiblePassword,
                          lable: 'Password',
                          prefix: Icons.lock,
                          suffix: RegisterCubit.get(context).icon,
                          obscure: RegisterCubit.get(context).obsecure,
                          show: (){
                            RegisterCubit.get(context).changeShowPassword();
                          },
                        ),
                        const SizedBox(height: 15.0,),
                        defultTextFormFeild(
                          validate: (value){
                            if(value!.isEmpty){
                              return 'please enter your phone';
                            }else
                            {
                              return null;
                            }
                          },
                          control: phoneController,
                          type: TextInputType.phone,
                          lable: 'Phone',
                          prefix: Icons.phone,
                        ),
                        const SizedBox(height: 30.0,),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder:(context)=> defultButton(
                            uperCase: true,
                            function: (){
                              if(formKey.currentState!.validate()){
                                RegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }

                              //navigation(context, widget),
                            },
                            text: 'Register',
                          ),
                          fallback:(context)=> const Center(child: CircularProgressIndicator()),
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