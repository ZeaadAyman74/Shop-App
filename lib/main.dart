import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_cubit/layout_cubit.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'cubit_observer.dart';

void main() async {
  // دي عشان تتاكد ان كل حاجة هنا في الميثود خلصت و بعدين يفتح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  Widget startWidget;
  bool? isDark = CacheHelper.getData(key: 'isDark');
  bool? isFirstTime = CacheHelper.getData(key: 'isFirstTime');
  token = CacheHelper.getData(key: 'token');
  print(token);

  if (isFirstTime != null) {
    if (token != null) {
      startWidget = const ShopLayoutScreen();
    } else {
      startWidget = LoginScreen();
    }
  } else {
    startWidget = const OnBoardingScreen();
  }

  BlocOverrides.runZoned(() => runApp(MyApp(isDark, startWidget)),
      blocObserver: AppBlocObserver());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  bool? isDark;
  Widget startsWidget;

  MyApp(this.isDark, this.startsWidget, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ShopCubit()..changeMode(isDark: isDark),
          ),
          BlocProvider(
            create: (context) => LayoutCubit()..getHomeData()..getCategoryData()..getFavoritesData()..getUser(),
          ),
        ],
        child: BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ShopCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: Directionality(
              textDirection: TextDirection.ltr,
              child: startsWidget,
            ),
          ),
        ));
  }
}
