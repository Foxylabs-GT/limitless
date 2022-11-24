import 'package:flutter/material.dart';
import 'package:limitless/screen/start_menu.dart';
import 'package:limitless/service/services.dart';
import 'package:limitless/util/responsive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool? loading = false;
  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              width: responsive.width,
              height: responsive.hp(20),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(40.0)),
              ),
            ),
            Flexible(
                child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    children: [
                      SizedBox(
                        height: responsive.hp(10),
                      ),
                      Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: responsive.dp(2.8),
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: responsive.hp(4),
                      ),
                      TextFormField(
                        controller: emailController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(right: 10, left: 10),
                          hintText: "",
                          hintStyle: TextStyle(
                              fontSize: responsive.dp(1.63),
                              color: Color(0XFF4D12121D),
                              fontWeight: FontWeight.w400),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100.0),
                            borderSide: const BorderSide(
                              color: Color(0XFF333333),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100.0),
                            borderSide: const BorderSide(
                              color: Color(0XFF333333),
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100.0),
                            borderSide: const BorderSide(
                              color: Color(0XFF333333),
                            ),
                          ),
                        ),
                        // onChanged: (value){
                        // },
                      ),
                      SizedBox(
                        height: responsive.hp(3),
                      ),
                      TextFormField(
                        controller: passController,
                        textInputAction: TextInputAction.go,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(right: 10, left: 10),
                          hintText: "",
                          hintStyle: TextStyle(
                              fontSize: responsive.dp(1.63),
                              color: Color(0XFF4D12121D),
                              fontWeight: FontWeight.w400),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100.0),
                            borderSide: const BorderSide(
                              color: Color(0XFF333333),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100.0),
                            borderSide: const BorderSide(
                              color: Color(0XFF333333),
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100.0),
                            borderSide: const BorderSide(
                              color: Color(0XFF333333),
                            ),
                          ),
                        ),
                        // onChanged: (value){
                        // },
                      ),
                      SizedBox(
                        height: responsive.hp(3),
                      ),
                      loading == true
                          ? Container(
                              width: responsive.width,
                              height: responsive.hp(6.5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [CircularProgressIndicator()],
                              ),
                            )
                          : GestureDetector(
                              onTap: () async {
                                if (emailController.text != '' &&
                                    passController.text != '') {
                                  loading = true;
                                  setState(() {});
                                  await Services().login(emailController.text,
                                      passController.text, context);
                                  loading = false;
                                  setState(() {});
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('Hay campos vacios.'),
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 1),
                                  ));
                                }
                              },
                              child: Container(
                                width: responsive.width,
                                height: responsive.hp(6.5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.black,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'LOGIN',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: responsive.dp(2.0),
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      SizedBox(
                        height: responsive.hp(4),
                      ),
                      Text(
                        'REGISTRARME!!!',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: responsive.dp(2.0),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
