import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/modes/themes_screen.dart';
import 'package:shop_app/modules/profile/profile_screen.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return Column(
          children: [
            ListTile(
              iconColor: defaultColor,
              style: ListTileStyle.list,
              leading: const Icon(
                Icons.account_circle,
                size: 30,
              ),
              title:  Text(
                "Account",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20),
              ),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.color_lens_outlined,
                color: defaultColor,
              ),
              title: Text(
                "Theme",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ModeScreen()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: defaultColor,
              ),
              title: Text(
                "LogOut",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20),
              ),
              onTap: () {
                CacheHelper.removeValue(key: 'token').then((value) {
                  if (value) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                  }
                });
              },
            ),

          ],
        );
      },
    );
  }
}

