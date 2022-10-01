import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/cubit/cubit.dart';
import 'package:shop_app/shared/components/cubit/states.dart';
import '../shared/components/comonents.dart';


class Favorites extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state)=>{},
      builder: (context,state){
        return ConditionalBuilder(
          condition: state is! GetFavoriteLoadingState,
          builder:(context)=> ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => listProduct(ShopCubit.get(context).favoriteModel.data.data[index].product,context),
            separatorBuilder: (context,index)=>myDivider(),
            itemCount: ShopCubit.get(context).favoriteModel.data.data.length,
          ),
          fallback: (context){
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      },
    );
  }
}