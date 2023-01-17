import 'package:flutter/material.dart';
import 'package:limitless/screen/login_screen.dart';
import 'package:limitless/screen/start_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: SplashScreenn(),
    );
  }
}

class SplashScreenn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreennState();
  }
}

class SplashScreennState extends State<SplashScreenn> {
  String idUser = "";

  loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      idUser = prefs.getString("idUserLimitless") ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: (idUser == '') ? LoginScreen() : TabUserWidget(page: 1),
      duration: 5000,
      imageSize: 150,
      imageSrc: "assets/icon/icon.jpg",
      backgroundColor: Colors.white,
    );
  }
}
