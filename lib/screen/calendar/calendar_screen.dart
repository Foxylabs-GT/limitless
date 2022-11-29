import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:limitless/screen/home/class_reservation_screen.dart';
import 'package:limitless/service/services.dart';
import 'package:limitless/util/responsive.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  TextEditingController searchController = TextEditingController();
  List? dataHorary = ['a'];

  loadUser(String date) async {
    dataHorary = await Services().ListHoraryDate(date);
    setState(() {});
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
                  Expanded(
                    flex: 4,
                    child: Text(
                      'CALENDARIO',
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
            Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  children: [
                    SizedBox(
                      height: responsive.hp(3),
                    ),
                    Theme(
                        data: ThemeData(primarySwatch: Colors.grey),
                        child: DateTimePicker(
                          controller: searchController,
                          firstDate: DateTime(1600),
                          lastDate: DateTime.now().add(Duration(days: 60)),
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                          decoration: InputDecoration(
                              hintText: "AAAA-MM-DD",
                              icon: Icon(Icons.search, color: Colors.black),
                              suffixIcon: Icon(Icons.calendar_month,
                                  color: Color(0XFF707070)),
                              hintStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0XFF707070)),
                              fillColor: Colors.white,
                              contentPadding:
                                  const EdgeInsets.only(left: 15, right: 15),
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
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100.0),
                                borderSide: const BorderSide(
                                  color: Color(0XFF333333),
                                ),
                              )),
                          dateMask: 'yyyy-MM-dd',
                          onChanged: (val) {
                            loadUser(val.toString());
                            //setState(() {});
                          },
                        )),
                    SizedBox(
                      height: responsive.hp(2),
                    ),
                  ],
                )),
            dataHorary.toString() == '[a]'
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: responsive.hp(28)),
                Text('Seleccionar fecha para encontrar horarios.')
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
                          SizedBox(
                            height: responsive.hp(3),
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
