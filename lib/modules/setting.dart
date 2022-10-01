import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/components/comonents.dart';
import 'package:shop_app/shared/components/cubit/cubit.dart';
import 'package:shop_app/shared/components/cubit/states.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';

import 'login/login.dart';

class Setting extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {
        if (state is GetUserSuccessState) {
          nameController.text = state.user.data.name;
          emailController.text = state.user.data.email;
          phoneController.text = state.user.data.phone;
        }
      },
      builder: (BuildContext context, Object? state) {
        LoginModel user=ShopCubit.get(context).user;
        nameController.text = user.data.name;
        emailController.text = user.data.email;
        phoneController.text = user.data.phone;
        print(user.data.email);
        return Center(
          child: SingleChildScrollView(
            child: ConditionalBuilder(
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        if(state is UpdateUserLoadingState)
                          const LinearProgressIndicator(),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defultTextFormFeild(
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'name must be not empty';
                            } else {
                              return null;
                            }
                          },
                          control: nameController,
                          type: TextInputType.name,
                          lable: 'User Name',
                          prefix: Icons.person,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defultTextFormFeild(
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'email must be not empty';
                            } else {
                              return null;
                            }
                          },
                          control: emailController,
                          type: TextInputType.emailAddress,
                          lable: 'Email Address',
                          prefix: Icons.email,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defultTextFormFeild(
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'phone must be not empty';
                            } else {
                              return null;
                            }
                          },
                          control: phoneController,
                          type: TextInputType.phone,
                          lable: 'Phone',
                          prefix: Icons.phone,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defultButton(
                          uperCase: true,
                          function: () {
                            if (formKey.currentState!.validate()) {
                              ShopCubit.get(context).updateUser(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                              );
                            }
                          },
                          text: 'update',
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defultButton(
                            uperCase: true,
                            function: () {
                              CashHelper.removeData(key: 'token').then((value) {
                                if (value) {
                                  navigationAndFinish(context, Login());
                                }
                              });
                            },
                            text: "sign out"),

                      ],
                    ),
                  ),
                );
              },
              condition: ShopCubit.get(context).user != null,
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    );
  }
}
