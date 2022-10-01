import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/comonents.dart';
import 'package:shop_app/shared/components/cubit/cubit.dart';
import 'package:shop_app/shared/components/cubit/states.dart';

import '../modules/search/search.dart';


class Home extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Shop App',
            ),
            actions: [
              IconButton(
                onPressed: (){
                  navigation(context, Search());
                },
                icon: const Icon(
                  Icons.search,
                ),
              ),
            ],
          ),
          body: ShopCubit.get(context).screens[ShopCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: ShopCubit.get(context).currentIndex,
            onTap: (index) {
              ShopCubit.get(context).changeScreens(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Products',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.apps),
                label: 'Categoris',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'settings',
              ),
            ],
          ),
        );
      },
      listener: (BuildContext context, Object? state) {  },

    );
  }
}