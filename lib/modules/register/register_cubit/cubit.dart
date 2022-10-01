import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/register/register_cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';


class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context)=>BlocProvider.of(context);

  bool obsecure=true;
  IconData icon=Icons.visibility;
  LoginModel user=LoginModel();
void changeShowPassword()
{
  obsecure=!obsecure;
  obsecure? (icon=Icons.visibility): (icon=Icons.visibility_off);
  emit(RegisterChangePasswordState());
}

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone

  }){
    emit(RegisterLoadingState());
    DioHelper.postData(
    url: REGISTER,
    data: {
      "name":name,
      "email":email,
      "password":password,
      "phone":phone,
    }).then((value) {
      user=LoginModel.fromJson(value.data);
      emit(RegisterSuccessState(user));
    }).catchError((error){
      emit(RegisterErrorState(error.toString()));
      print(error.toString());
    });
  }

}