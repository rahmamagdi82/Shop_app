import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_models.dart';
import 'package:shop_app/shared/components/comonents.dart';
import 'package:shop_app/shared/components/cubit/cubit.dart';
import 'package:shop_app/shared/components/cubit/states.dart';
import 'package:shop_app/shared/style/colors.dart';


class Products extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        builder: (context,builder){
          return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoryModel != null,
            builder: (builder){
              return item(ShopCubit.get(context).homeModel,ShopCubit.get(context).categoryModel,context);
            },
            fallback: (context){
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
        listener: (context,state){
          if(state is ChangeFavoriteSuccessState){
            if(state.changeFavoriteModel.status==false){
              toast(
                message: state.changeFavoriteModel.message,
                color: Colors.red,
              );
            }
          }
        },
    );
  }

  Widget item(HomeModels homeModel,CategoriesModel categoriesModel,context)=>SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
            items: homeModel.data.banners.map((e) => Image(
              image: NetworkImage(e.image),
              width: double.infinity,
              fit: BoxFit.cover,
            ),).toList(),
            options: CarouselOptions(
              height: 250.0,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlayInterval: const Duration(milliseconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
        ),
        const SizedBox(height: 10.0,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10.0,),
              Container(
                height: 100.0,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index)=>defultCategory(categoriesModel.data.data[index]),
                    separatorBuilder: (context,index)=>SizedBox(width: 10.0,),
                    itemCount:categoriesModel.data.data.length,
                ),
              ),
              const SizedBox(height: 20.0,),
              const Text(
                'New Products',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0,),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            childAspectRatio: 1/1.61,
            children: List.generate(
              homeModel.data.products.length,
              (index) {
              return defultProduct(homeModel.data.products[index],context);
            },
            ),
          ),
        ),
      ],
    ),
  );


  Widget defultCategory(DataModel data)=>Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        width: 100.0,
        height: 100.0,
        fit: BoxFit.cover,
        image: NetworkImage(data.image),
      ),
      Container(
        width: 100.0,
        color: Colors.black.withOpacity(0.8),
        child: Text(
          data.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white
          ),
        ),
      ),
    ],
  );


  Widget defultProduct(ProductModel model,context)=>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image(
                  image: NetworkImage(model.image),
                  width: double.infinity,
                  height: 180.0,
                ),
                  if(model.discount != 0)
                   Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    color: Colors.red,
                    child: const Text(
                      'DISCOUNT',
                      style:TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
                alignment: AlignmentDirectional.bottomStart,
              ),
              Text(
                model.name,
                style: const TextStyle(
                  fontSize: 14.0,
                  height: 1.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  if(model.discount != 0)
                    Text(
                    '${model.oldPrice.round()}',
                    style: const TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const Spacer(),
                  CircleAvatar(
                    backgroundColor: (ShopCubit.get(context).favorites[model.id]==true)?defaultColor:Colors.grey,
                    child: IconButton(
                        onPressed: (){
                          ShopCubit.get(context).changeFavorites(model.id);
                        },
                        icon: const Icon(
                          Icons.favorite_border,
                          size: 20.0,
                          color: Colors.white,
                        ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

}