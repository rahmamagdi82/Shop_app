import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/models/home_models.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/categories.dart';
import 'package:shop_app/modules/favorites.dart';
import 'package:shop_app/modules/products.dart';
import 'package:shop_app/modules/setting.dart';
import 'package:shop_app/shared/components/comonents.dart';
import 'package:shop_app/shared/components/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(InitialState());
  static ShopCubit get(context)=>BlocProvider.of(context);

  bool darkMode=false;
  void changeMode({bool? fromShared})
  {
    if(fromShared != null){
      darkMode=fromShared;
      emit(ChangeModeState());
    }else
    {
      darkMode = !darkMode;
      CashHelper.putData(key: 'darkMode', value: darkMode).then((value) {
        emit(ChangeModeState());
      });
    }
  }

  List screens=
  [
    Products(),
    Categoris(),
    Favorites(),
    Setting(),
  ];
  int currentIndex=0;
  void changeScreens(int x)
  {
    currentIndex=x;
    emit(ChangeState());
  }

  HomeModels homeModel=  HomeModels();
  Map<int,bool> favorites={};
  void getHome()
  {
    emit(HomeLoadingState());
    DioHelper.getData(
        url: HOME,
      token: token,
        ).then((value) {
          homeModel=HomeModels.fromJson(value.data);
          homeModel.data.products.forEach((element) {
            favorites.addAll({
              element.id:element.inFavorite,
            });
          });
          emit(HomeSuccessState(homeModel));
    }).catchError((error){
      emit(HomeErrorState(error.toString()));
      print(error.toString());
    });
  }


  CategoriesModel categoryModel=  CategoriesModel();
  void getCategories()
  {
    emit(CategoryLoadingState());
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoryModel=CategoriesModel.fromJson(value.data);
      emit(CategorySuccessState(categoryModel));
    }).catchError((error){
      emit(CategoryErrorState(error.toString()));
      print(error.toString());
    });

  }

  ChangeFavoritesModel changeFavoriteModel=ChangeFavoritesModel();
void changeFavorites(int productId)
{
  if(favorites[productId] == true){
    favorites[productId]=false;
    emit(ChangeFavoriteSuccessState(changeFavoriteModel));
  }else
    {
    favorites[productId]=true;
    emit(ChangeFavoriteSuccessState(changeFavoriteModel));
    }

  DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id':productId,
      },
    token: token,
  ).then((value) {
    changeFavoriteModel=ChangeFavoritesModel.fromJson(value.data);
    if(changeFavoriteModel.status==false){
      if(favorites[productId] == true){
        favorites[productId]=false;
        emit(ChangeSuccessState());
      }else
      {
        favorites[productId]=true;
        emit(ChangeSuccessState());
      }
    } else
      {
        getFavorite();
      }
emit(ChangeFavoriteSuccessState(changeFavoriteModel));
  }).catchError((error){
    if(favorites[productId] == true){
      favorites[productId]=false;
      emit(ChangeFavoriteSuccessState(changeFavoriteModel));
    }else
    {
      favorites[productId]=true;
      emit(ChangeFavoriteSuccessState(changeFavoriteModel));
    }
emit(ChangeFavoriteErrorState());
  });
}

  FavoriteModel favoriteModel=FavoriteModel();
  void getFavorite()
  {
    emit(GetFavoriteLoadingState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoriteModel=FavoriteModel.fromJson(value.data);
      emit(GetFavoriteSuccessState());
    }).catchError((error){
      emit(GetFavoriteErrorState());
      print(error.toString());
    });
  }

  LoginModel user = LoginModel();

  void getUser()
  {
    emit(GetUserLoadingState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      user=LoginModel.fromJson(value.data);
      emit(GetUserSuccessState(user));
    }).catchError((error){
      emit(GetUserErrorState());
      print(error.toString());
    });

  }

  LoginModel updateUserdata = LoginModel();
  void updateUser({
  required String name,
    required String email,
    required String phone,

  })
  {
    emit(UpdateUserLoadingState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      },
    ).then((value) {
      updateUserdata=LoginModel.fromJson(value.data);
      emit(UpdateUserSuccessState(updateUserdata));
    }).catchError((error){
      emit(UpdateUserErrorState());
      print(error.toString());
    });

  }
}