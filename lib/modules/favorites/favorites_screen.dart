import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_cubit/layout_cubit.dart';
import 'package:shop_app/layout/shop_cubit/layout_states.dart';
import 'package:shop_app/shared/styles/colors.dart';
import '../../models/favorites_model.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        LayoutCubit cubit = LayoutCubit.get(context);
        return ConditionalBuilder(
            condition:cubit.favoritesModel!.data!.data!.isNotEmpty ,
          builder:(context)=>buildFavorites(cubit.favoritesModel!.data!.data),
          fallback:(context)=>const Center(child:Text("No favorites Yet !",style: TextStyle(color: Colors.grey,fontSize: 30),)) ,
        );
      },
    );
  }

  Widget favoriteItem( model, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        height: 150,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage('${model.image}'),
                  height: 150,
                  width: 150,
                ),
                if (model.discount != 0)
                  Container(
                    color: Colors.red,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        "DISCOUNT",
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${model.name}",
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.price}',
                        style:
                            const TextStyle(color: defaultColor, fontSize: 16),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice}',
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                      const Spacer(),
                      CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        child: IconButton(
                            onPressed: () {
                              LayoutCubit.get(context)
                                  .changeFavorites(model.productId!);
                            },
                            icon: LayoutCubit.get(context)
                                    .favorites[model.productId!]!
                                ? const Icon(
                                    Icons.favorite,
                                    color: defaultColor,
                                  )
                                : const Icon(Icons.favorite_border_outlined,color: Colors.white,)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFavorites(List<ProductData>? myList) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => favoriteItem(myList![index].product!, context),
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          color: Colors.grey,
          height: 1,
          width: double.infinity,
        ),
      ),
      itemCount: myList!.length,
    );
  }
}
