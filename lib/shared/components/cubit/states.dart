import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/home_models.dart';
import 'package:shop_app/models/login_model.dart';

abstract class ShopStates
{}

class InitialState extends ShopStates
{}

class ChangeModeState extends ShopStates
{}
class ChangeState extends ShopStates
{}

class HomeLoadingState extends ShopStates
{}

class HomeSuccessState extends ShopStates
{
  final HomeModels homeModels;
  HomeSuccessState(this.homeModels);
}

class HomeErrorState extends ShopStates
{
  final String error;
  HomeErrorState(this.error);
}

class CategoryLoadingState extends ShopStates
{}

class CategorySuccessState extends ShopStates
{
  final CategoriesModel CategoryModel;
  CategorySuccessState(this.CategoryModel);
}

class CategoryErrorState extends ShopStates
{
  final String error;
  CategoryErrorState(this.error);
}

class ChangeFavoriteSuccessState extends ShopStates
{
  final ChangeFavoritesModel changeFavoriteModel;
  ChangeFavoriteSuccessState(this.changeFavoriteModel);
}

class ChangeFavoriteErrorState extends ShopStates
{}

class ChangeSuccessState extends ShopStates
{}

class GetFavoriteLoadingState extends ShopStates
{}

class GetFavoriteErrorState extends ShopStates
{}

class GetFavoriteSuccessState extends ShopStates
{}

class GetUserLoadingState extends ShopStates
{}

class GetUserErrorState extends ShopStates
{}

class GetUserSuccessState extends ShopStates
{
  final LoginModel user;
  GetUserSuccessState(this.user);
}

class UpdateUserLoadingState extends ShopStates
{}

class UpdateUserErrorState extends ShopStates
{}

class UpdateUserSuccessState extends ShopStates
{
  final LoginModel user;
  UpdateUserSuccessState(this.user);
}