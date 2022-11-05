import 'package:flutter/material.dart';
import 'package:limitless/util/responsive.dart';

class ClassReservationScreen extends StatefulWidget {
  const ClassReservationScreen({Key? key}) : super(key: key);

  @override
  State<ClassReservationScreen> createState() => _ClassReservationScreenState();
}

class _ClassReservationScreenState extends State<ClassReservationScreen> {
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
                  Expanded(
                    child: Text(
                      'POLE DANCE',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: responsive.dp(2.5),
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: responsive.hp(3),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: responsive.width,
                            height: responsive.hp(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.black,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'HORA: 7:00 PM',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: responsive.dp(1.6),
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: responsive.wp(1),
                        ),
                        Expanded(
                          child: Container(
                            width: responsive.width,
                            height: responsive.hp(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.black,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'LUGAR: Salon 3',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: responsive.dp(1.6),
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: responsive.hp(2),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: responsive.width,
                            height: responsive.hp(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.black,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'LUISA PEREREZ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: responsive.dp(1.6),
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: responsive.wp(1),
                        ),
                        Expanded(
                          child: Container(
                            width: responsive.width,
                            height: responsive.hp(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.black,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'LIBRES: 4',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: responsive.dp(1.6),
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: responsive.hp(3),
                    ),
                    GestureDetector(
                        onTap: () {
                          // Navigator.of(context).pushReplacement(PageRouteBuilder(
                          //     pageBuilder: (BuildContext context, _, __) {
                          //       return TabUserWidget(
                          //         page: 1,
                          //       );
                          //     }, transitionsBuilder:
                          //     (_, Animation<double> animation, __, Widget child) {
                          //   return FadeTransition(opacity: animation, child: child);
                          // }));
                        },
                        child: Container(
                          width: responsive.width,
                          height: responsive.hp(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.black,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'RESERVAR',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: responsive.dp(2.0),
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        )),
                  ],
                )),
            SizedBox(
              height: responsive.hp(1),
            ),
            Flexible(
                child: ListView(
              children: [
                SizedBox(
                  height: responsive.hp(3),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      Container(
                        width: responsive.width,
                        height: responsive.hp(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.grey),
                          color: Colors.transparent,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.lightGreen,
                                  shape: BoxShape.circle
                                ),
                              )
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                'Marta L. Perez',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: responsive.dp(2.5),
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: responsive.hp(2),
                      ),
                      Container(
                        width: responsive.width,
                        height: responsive.hp(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.grey),
                          color: Colors.transparent,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.lightGreen,
                                      shape: BoxShape.circle
                                  ),
                                )
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                'Marta L. Perez',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: responsive.dp(2.5),
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
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
                  'CANCELAR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            backgroundColor: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            }));
  }
}
