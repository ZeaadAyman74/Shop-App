import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_cubit/layout_states.dart';
import 'package:shop_app/models/categories_model.dart';

import '../../layout/shop_cubit/layout_cubit.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,LayoutStates>(
      listener:(context, state) {},
      builder: (context,state){
        LayoutCubit cubit=LayoutCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.categoryModel !=null,
            builder:(context)=>ListView.separated(
              itemBuilder:(context,index)=>buildCatItem(cubit.categoryModel!.data!.categoryData[index],context),
                separatorBuilder:(context,index)=>Container(color: Colors.grey,height: 1,width: double.infinity,),
                itemCount: cubit.categoryModel!.data!.categoryData.length,
            ) ,
            fallback: (context)=>const Center(child: CircularProgressIndicator(),),
        );
      },
    );

  }
  Widget buildCatItem(DataInfo model,BuildContext context)=> Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children:  [
        Image(image: NetworkImage('${model.image}'),height: 120,width: 120,fit: BoxFit.fill,),
        const SizedBox(width: 10,),
        Text("${model.name}",style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20)),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios),
      ],
    ),
  );
}

