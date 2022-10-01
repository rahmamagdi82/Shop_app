import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/search_cubit/cubit.dart';
import 'package:shop_app/modules/search/search_cubit/states.dart';
import 'package:shop_app/shared/components/comonents.dart';


class Search extends StatelessWidget
{
  var searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultTextFormField(
                      validate: (value){
                        if(value!.isEmpty){
                          return 'search must be not empty';
                        }else
                        {
                          return null;
                        }
                      },
                      control: searchController,
                      type: TextInputType.text,
                      label: 'Search',
                      prefix: Icons.search,
                      submit: (value){
                        SearchCubit.get(context).getSearch(text: value);
                      },
                  ),
                  const SizedBox(height: 10.0,),
                  if(state is SearchLoadingState)
                   const LinearProgressIndicator(),
                  const SizedBox(height: 10.0,),
                  if(state is SearchSuccessState)
                   Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => listProduct(SearchCubit.get(context).search.data.data[index],context,isOldPrice: false),
                      separatorBuilder: (context,index)=>myDivider(),
                      itemCount: SearchCubit.get(context).search.data.data.length,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}