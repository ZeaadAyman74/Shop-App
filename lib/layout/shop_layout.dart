import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_cubit/layout_cubit.dart';
import 'package:shop_app/layout/shop_cubit/layout_states.dart';
import 'package:shop_app/modules/search/search_screen.dart';

class ShopLayoutScreen extends StatelessWidget {
  const ShopLayoutScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,LayoutStates>(
      listener: (context, state) {},
      builder: (context,state){
        var cubit=LayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: cubit.bottomScreens[cubit.currentIndex]['title'],
            actions: [
              IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));}, icon:const Icon(Icons.search))
            ],
          ),
          body:cubit.bottomScreens[cubit.currentIndex]['page'],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex:cubit.currentIndex ,
             onTap: (index){
              cubit.changeBottomScreen(index);
             },
             items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.apps),label: "Categories"),
              BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "Favourites"),
               BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Settings"),
             ],
          ),
        );
      },
    );
  }
}
