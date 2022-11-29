import 'package:flutter/material.dart';
import 'package:limitless/screen/home/class_reservation_screen.dart';
import 'package:limitless/screen/home/class_screen.dart';
import 'package:limitless/screen/login_screen.dart';
import 'package:limitless/service/services.dart';
import 'package:limitless/util/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List? dataHorary = ['a'];

  loadUser() async {
    dataHorary = await Services().ListHoraryAll();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive.of(context);
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(0.0), // here the desired height
            child: AppBar()),
        body: Column(
          children: [
            Container(
              width: responsive.width,
              height: responsive.hp(13),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60.0),
                    bottomRight: Radius.circular(60.0)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.remove('idUserLimitless');
                          await prefs.clear();
                          Navigator.of(context).pushReplacement(
                              PageRouteBuilder(
                                  pageBuilder: (BuildContext context, _, __) {
                            return LoginScreen();
                          }, transitionsBuilder: (_,
                                      Animation<double> animation,
                                      __,
                                      Widget child) {
                            return FadeTransition(
                                opacity: animation, child: child);
                          }));
                        },
                        child: Icon(
                          Icons.exit_to_app,
                          color: Colors.white,
                          size: responsive.dp(3),
                        ),
                      )),
                  SizedBox(
                    width: responsive.wp(5),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      'CLASES DEL DIA',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: responsive.dp(2.5),
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  SizedBox(
                    width: responsive.wp(5),
                  ),
                  Flexible(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (BuildContext context, _, __) {
                                return ClassScreen();
                              }, transitionsBuilder: (_,
                                      Animation<double> animation,
                                      __,
                                      Widget child) {
                                return FadeTransition(
                                    opacity: animation, child: child);
                              }));
                        },
                        child: Icon(
                          Icons.send,
                          color: Colors.blue,
                          size: responsive.dp(5),
                        ),
                      ))
                ],
              ),
            ),
            dataHorary.toString() == '[a]'
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: responsive.hp(30)),
                      CircularProgressIndicator()
                    ],
                  )
                : dataHorary?.length == 0
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: responsive.hp(30)),
                          Text(
                              'No se encontraron nuevos horarios para reservar.')
                        ],
                      )
                    : Flexible(
                        child: ListView.builder(
                        itemCount: dataHorary?.length,
                        itemBuilder: (context, i) {
                          return Container(
                            margin: EdgeInsets.only(left: 30, right: 30),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: responsive.hp(3),
                                ),
                                Container(
                                  padding: EdgeInsets.all(20),
                                  width: responsive.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.black,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              dataHorary?[i]['clase']['nombre'],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: responsive.dp(2.0),
                                                  fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'HORA:',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: responsive.dp(2.0),
                                                  fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              DateFormat("HH:mm")
                                                  .format(DateTime.parse(
                                                      dataHorary?[i]
                                                          ['fechaHora']))
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: responsive.dp(2.0),
                                                  fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.end,
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'LUGAR:',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: responsive.dp(2.0),
                                                  fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              dataHorary?[i]['lugar']['nombre'],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: responsive.dp(2.0),
                                                  fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.end,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: responsive.hp(1),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              dataHorary?[i]['academia']
                                                          ['nombre']
                                                      .toString() ??
                                                  '',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: responsive.dp(2.0),
                                                  fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.start,
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'LIBRES:',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: responsive.dp(2.0),
                                                  fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              dataHorary?[i]['cantidad']
                                                      .toString() ??
                                                  '',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: responsive.dp(2.0),
                                                  fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.end,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: responsive.hp(3),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              PageRouteBuilder(pageBuilder:
                                                  (BuildContext context, _,
                                                      __) {
                                                return ClassReservationScreen(
                                                  id: dataHorary?[i]['id']
                                                      .toString(),
                                                );
                                              }, transitionsBuilder: (_,
                                                  Animation<double> animation,
                                                  __,
                                                  Widget child) {
                                                return FadeTransition(
                                                    opacity: animation,
                                                    child: child);
                                              }));
                                          // Navigator.of(context).pushReplacement(
                                          //     PageRouteBuilder(pageBuilder:
                                          //         (BuildContext context, _, __) {
                                          //   return ClassReservationScreen();
                                          // }, transitionsBuilder: (_,
                                          //         Animation<double> animation,
                                          //         __,
                                          //         Widget child) {
                                          //   return FadeTransition(
                                          //       opacity: animation, child: child);
                                          // }));
                                        },
                                        child: Container(
                                          width: responsive.width,
                                          height: responsive.hp(5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'RESERVAR',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize:
                                                        responsive.dp(2.0),
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ))
          ],
        ),
        floatingActionButton: FloatingActionButton(
            elevation: 1.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '3',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Pendientes',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 7,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            backgroundColor: Colors.lightGreen,
            onPressed: () {}));
  }
}
