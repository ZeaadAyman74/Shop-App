import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/shared/styles/colors.dart';



ThemeData darkTheme=ThemeData(
  scaffoldBackgroundColor: HexColor('333739'),
  primarySwatch:myColor,
  appBarTheme:  AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness:Brightness.light,
    ),
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 25,
      fontWeight: FontWeight.w600,
    ),
    backgroundColor: HexColor('333739'),
    elevation: 0.0,
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      )
  ),
  bottomNavigationBarTheme:  BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.grey,
    backgroundColor: HexColor('333739'),
    elevation: 20,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.deepOrange,
  ),

);

ThemeData lightTheme=ThemeData(
  scaffoldBackgroundColor: Colors.white,
 primarySwatch: myColor,
  appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness:Brightness.dark,
      ),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor:Colors.white,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.black)
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: defaultColor,
  ),
  textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: Colors.black,
        fontSize: 18,
         fontWeight: FontWeight.w600,
      )
  ),
  fontFamily: 'Zoz',
);