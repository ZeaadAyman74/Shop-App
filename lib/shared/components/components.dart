import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/styles/colors.dart';

import '../../layout/shop_cubit/layout_cubit.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = defaultColor,
  Color foreColor = Colors.white,
  bool isUpperCase = true,
  required String txt,
  required Function() function,
  double radius = 0.0,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? txt.toUpperCase() : txt,
          style: TextStyle(fontSize: 17, color: foreColor),
        ),
      ),
    );

Widget defaultFormField({
  required BuildContext context,
  required TextEditingController myController,
  required TextInputType type,
  required String? Function(String? value) validate,
  required String label,
  required IconData prefix,
  Function(String value)? onSubmit,
  Function(String value)? onChange,
  IconData? sufix,
  Function()? sufixPress,
  bool isPassword = false,
  void Function()? onTap,
  bool isBorder=false,
  double raduis=0,
}) => TextFormField(
  style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20),
  controller: myController,
  keyboardType: type,
  validator: validate,
  obscureText: isPassword,
  onFieldSubmitted: onSubmit,
  onChanged: onChange,
  onTap: onTap,
  decoration: InputDecoration(
   // labelText: label,
    //labelStyle: const TextStyle(color: defaultColor),
    hintText: label,
    hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15),
    prefixIcon: Icon(prefix,color:  ShopCubit.get(context).isDark ? Colors.white : defaultColor ),
    suffixIcon: IconButton(
      icon: Icon(sufix,color: ShopCubit.get(context).isDark ? Colors.white : defaultColor,),
      onPressed: sufixPress,
      color: ShopCubit.get(context).isDark ? Colors.white : Colors.black ,
    ),

    border:  isBorder? const OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)) :null ,
  ),
);


void showToast({required String message,required ToastStates state})=>Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0);

enum ToastStates {SUCCESS,WARNING,ERROR}

Color chooseToastColor(ToastStates state){
  switch(state){
    case ToastStates.ERROR:
      return Colors.red;
    case ToastStates.SUCCESS:
      return Colors.green;
    case ToastStates.WARNING:
      return Colors.amber;
  }

}

Widget favoriteItem( model, BuildContext context,{bool isSearch=false}) {
  return PhysicalModel(
    color: Colors.white54,
    elevation: 5,
    borderRadius:BorderRadius.circular(8),
    child: SizedBox(

      height: 130,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model.image}'),
                height: 130,
                width: 100, fit: BoxFit.fill,
              ),

              if(isSearch==false)
                if (model.discount != 0 )
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
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.price}',
                      style:
                      const TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                    const SizedBox(
                      width: 5,
                    ),

                    if(isSearch==false)
                      if (model.discount != 0)
                      Text(
                        '${model.oldPrice}',
                        style:
                        const TextStyle(color: Colors.grey, fontSize: 10),
                      ),

                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          LayoutCubit.get(context)
                              .changeFavorites(model.productId!);
                        },
                        icon: LayoutCubit.get(context)
                            .favorites[model.productId!]!
                            ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                            : const Icon(Icons.favorite_border_outlined)),
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
