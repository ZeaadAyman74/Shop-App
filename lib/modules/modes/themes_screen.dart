import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ModeScreen extends StatelessWidget {
  const ModeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title:
                const Text("Set theme", ),
          ),
          body: Column(
            children: [
              ListTile(
                leading: Text(
                  "Light",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontSize: 25),
                ),
                trailing: Icon(
                  cubit.isDark
                      ? Icons.circle_outlined
                      : Icons.check_circle_rounded,
                  size: 30,
                  color: defaultColor,
                ),
                onTap: () {
                  cubit.changeMode();
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                  leading: Text(
                    "Dark",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(fontSize: 25),
                  ),
                  trailing: Icon(
                    cubit.isDark
                        ? Icons.check_circle_rounded
                        : Icons.circle_outlined,
                    size: 30,
                    color: defaultColor,
                  ),
                onTap: (){cubit.changeMode();},
              ),

            ],
          ),

        );
      },
    );
  }
}
