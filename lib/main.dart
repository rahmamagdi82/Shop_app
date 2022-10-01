import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home.dart';
import 'package:shop_app/shared/components/cubit/bloc_observe.dart';
import 'package:shop_app/shared/components/cubit/cubit.dart';
import 'package:shop_app/shared/components/cubit/states.dart';
import 'package:shop_app/shared/style/themes.dart';
import 'modules/login/login.dart';
import 'modules/on_boarding.dart';
import 'shared/components/comonents.dart';
import 'shared/network/local/cash_helper.dart';
import 'shared/network/remote/dio_helper.dart';

void main() async{
  Widget widget;

  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.initial();
  await CashHelper.initial();
  bool? skip;
  skip=CashHelper.getData(key: 'isSkip');
  token=CashHelper.getData(key: 'token');
  BlocOverrides.runZoned(
        () {
          if(skip != null)
          {
            if(token != null)
            {
              widget=Home();
            }else
            {
              widget=Login();
            }
          }else
          {
            widget=OnBoardingScreen();
          }

      runApp(MyApp(startWidget: widget,));
    },
    blocObserver: MyBlocObserver(
    ),
  );
}


class MyApp extends StatelessWidget {

  Widget? startWidget;
  MyApp({this.startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>ShopCubit()..getHome()..getCategories()..getFavorite()..getUser(),
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home:startWidget,
            theme: lightTheme(),
            themeMode:ShopCubit.get(context).darkMode? ThemeMode.dark:ThemeMode.light,
          );
        },
      ),
    );
  }
}