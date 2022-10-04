import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login/login_cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';


class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context)=>BlocProvider.of(context);

  bool obsecure=true;
  IconData icon=Icons.visibility;
  LoginModel user=LoginModel();
void changeShowPassword()
{
  obsecure=!obsecure;
  obsecure? (icon=Icons.visibility): (icon=Icons.visibility_off);
  emit(LoginChangePasswordState());
}

  void userLogin({
    required String email,
    required String password,
  }){
    emit(LoginLoadingState());
    DioHelper.postData(
    url: LOGIN,
    data: {
      "email":email,
      "password":password,
    }).then((value) {
      user=LoginModel.fromJson(value.data);
      emit(LoginSuccessState(user));
    }).catchError((error){
      emit(LoginErrorState(error.toString()));
      print(error.toString());
    });
  }

}