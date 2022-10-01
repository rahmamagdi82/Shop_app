import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/shared/components/comonents.dart';
import 'package:shop_app/shared/components/cubit/cubit.dart';
import 'package:shop_app/shared/components/cubit/states.dart';


class Categoris extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
     listener: (context,state)=>{},
      builder: (context,state){
        return ListView.separated(
        itemBuilder: (context, index) => category(ShopCubit.get(context).categoryModel.data.data[index],context),
    separatorBuilder: (context,index)=>myDivider(),
    itemCount: ShopCubit.get(context).categoryModel.data.data.length,
    );
      },
    );
  }

  Widget category(DataModel data,context)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          height: 80.0,
          width: 80.0,
          fit: BoxFit.cover,
          image: NetworkImage(
            data.image,
          ),
        ),
        SizedBox(width: 20.0,),
        Text(
          data.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          //style: Theme.of(context).textTheme.headline6,
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        Spacer(),
        Icon(
          Icons.arrow_forward_ios,
        ),
      ],
    ),
  );
}