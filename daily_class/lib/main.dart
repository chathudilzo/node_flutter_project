import 'package:daily_class/blocs/home/home_page.dart';
import 'package:daily_class/blocs/home/items_controller.dart';
import 'package:daily_class/blocs/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs=await SharedPreferences.getInstance();
  Get.put(ItemController());

  runApp( MyApp(token:prefs.getString('token'),));
}

class MyApp extends StatelessWidget {
  final token;
  const MyApp({super.key, required this.token});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: (token!=null && JwtDecoder.isExpired(token)==false)?HomePage(token: token,):RegisterPage(),
    );
  }
}
