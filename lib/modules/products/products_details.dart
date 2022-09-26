import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import '../../layout/shop_cubit/layout_cubit.dart';
import '../../models/categories_model.dart';
import '../../models/home_model.dart';
import '../../shared/styles/colors.dart';

Widget productItemBuilder(ProductModel model, context) => Container(
  height: 250,
  width: 200,
  padding: const EdgeInsets.all(8),
  decoration:   BoxDecoration(
    borderRadius: const BorderRadius.all(Radius.circular(12)),
    color: ShopCubit.get(context).isDark ?  HexColor('333739') : Colors.white,

  ),

  child: Column(

    crossAxisAlignment: CrossAxisAlignment.start,

    children: [

      Expanded(
        child: Container(

          width: double.infinity,

          decoration: const BoxDecoration(

            borderRadius: BorderRadius.all(Radius.circular(12)),

            color: primaryColor,

          ),

          child: Image.network(
            '${model.image}',
            height: 100,

          ),

        ),
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

      const SizedBox(

        height: 10,

      ),

      Padding(

        padding: const EdgeInsetsDirectional.all(5),

        child: Text(

          '${model.name}',

          style: const TextStyle(fontSize: 16, height: 1.2),

          maxLines: 2,

        ),

      ),

      Padding(
        padding: const EdgeInsets.only(bottom: 5),

        child: Row(

          children: [

            Padding(

              padding: const EdgeInsetsDirectional.only(start: 5),

              child: Text(

                '${model.price.round() ?? " "}',

                style: const TextStyle(color: defaultColor, fontSize: 16),

              ),

            ),

            const SizedBox(

              width: 5,

            ),

            if (model.discount != 0)

              Text(

                '${model.oldPrice.round() ?? " "}',

                style: const TextStyle(color: Colors.grey, fontSize: 10),

              ),

            const Spacer(),

            CircleAvatar(

              backgroundColor: Colors.grey[300],

              child: IconButton(

                onPressed: () {

                  LayoutCubit.get(context).changeFavorites(model.id);

                },

                icon: LayoutCubit.get(context).favorites[model.id] == true

                    ? const Icon(

                  Icons.favorite,

                  color: defaultColor,

                )

                    : const Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.white,
                ),

              ),

            )

          ],

        ),

      ),

    ],

  ),

);

Widget categoryItemBuilder(DataInfo model) => SizedBox(
  width: 100,
  child: Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image: NetworkImage('${model.image}'),
        height: 100,
        fit: BoxFit.cover,
      ),
      Container(
        width: double.infinity,
        color: Colors.black.withOpacity(.7),
        child: Text(
          '${model.name}',
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  ),
);
