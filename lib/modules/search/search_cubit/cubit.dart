import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/search_cubit/states.dart';
import 'package:shop_app/shared/components/comonents.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';


class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context)=>BlocProvider.of(context);

  SearchModel search=SearchModel();

  void getSearch({
    required String text,
  }){
    emit(SearchLoadingState());
    DioHelper.postData(
    url: SEARCH,
    token: token,
    data: {
      "text":text,
    }).then((value) {
      search=SearchModel.fromJson(value.data);
      print(search.data.data.first.name);
      emit(SearchSuccessState());
    }).catchError((error){
      emit(SearchErrorState());
      print(error.toString());
    });
  }

}