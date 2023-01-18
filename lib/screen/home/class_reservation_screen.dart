import 'package:flutter/material.dart';
import 'package:limitless/screen/start_menu.dart';
import 'package:limitless/service/services.dart';
import 'package:limitless/util/responsive.dart';
import 'package:intl/intl.dart';

class ClassReservationScreen extends StatefulWidget {
  ClassReservationScreen({Key? key, this.id}) : super(key: key);
  String? id;

  @override
  State<ClassReservationScreen> createState() => _ClassReservationScreenState();
}

class _ClassReservationScreenState extends State<ClassReservationScreen> {
  List? dataHorarydetaild = ['a'];
  List? student;
  bool? loading = false;
  bool? reservation = false;

  loadUser() async {
    dataHorarydetaild = await Services().HoraryDetail(widget.id);
    student = dataHorarydetaild?[0]['alumnos'];
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('AAAAAAAAAAAAAAAAAA');
    print(widget.id);
    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive.of(context);
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(0.0), // here the desired height
            child: AppBar()),
        body: dataHorarydetaild.toString() == '[a]'
            ? Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: responsive.hp(30)),
                    CircularProgressIndicator()
                  ],
                ),
              )
            : dataHorarydetaild?.length == 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: responsive.hp(30)),
                      Text('No se encontraron nuevos horarios reservados')
                    ],
                  )
                : Column(
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
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Colors.black,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'HORA: ' +
                                                DateFormat("HH:mm")
                                                    .format(DateTime.parse('${dataHorarydetaild?[0]['fechaFin']} ${dataHorarydetaild?[0]['horaFin']}'))
                                                    .toString(),
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
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Colors.black,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Colors.black,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Colors.black,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'LIBRES: ${dataHorarydetaild?[0]['cantidad'].toString() ?? ''}',
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
                              loading == false
                                  ? GestureDetector(
                                      onTap: () async {
                                        loading = true;
                                        setState(() {});
                                        if(reservation == false){
                                          bool? validation = await Services().ReservationHorary(
                                              context, widget.id.toString(), dataHorarydetaild?[0]['academiaId'].toString() ?? '');
                                          if(validation == true){
                                            loading = false;
                                            reservation = true;
                                            setState(() {});
                                          }else{
                                            loading = false;
                                            reservation = false;
                                            setState(() {});
                                          }
                                        }
                                      },
                                      child: Container(
                                        width: responsive.width,
                                        height: responsive.hp(5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: reservation == true?Colors.green:Colors.black,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              reservation == true?'RESERVADO':'RESERVAR',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: responsive.dp(2.0),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ))
                                  : Container(
                                      child: Column(
                                        children: [
                                          CircularProgressIndicator(
                                            color: Colors.black,
                                          )
                                        ],
                                      ),
                                    ),
                            ],
                          )),
                      SizedBox(
                        height: responsive.hp(3),
                      ),
                      Flexible(
                          child: ListView.builder(
                        itemCount: student?.length,
                        itemBuilder: (context, i) {
                          return Container(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                            margin: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: Colors.lightGreen,
                                                shape: BoxShape.circle),
                                          )),
                                      Expanded(
                                        flex: 4,
                                        child: Text(
                                          '${student?[i]['nombre']} ${student?[i]['apellido']}',
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
                              ],
                            ),
                          );
                        },
                      )),
                      SizedBox(
                        height: responsive.hp(1),
                      ),
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
