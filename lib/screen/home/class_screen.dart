import 'package:flutter/material.dart';
import 'package:limitless/service/services.dart';
import 'package:limitless/util/responsive.dart';
import 'package:intl/intl.dart';

class ClassScreen extends StatefulWidget {
  const ClassScreen({Key? key}) : super(key: key);

  @override
  State<ClassScreen> createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> {
  List? dataHoraryStudent = ['a'];

  loadUser() async {
    dataHoraryStudent = await Services().HoraryStudent();
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
                  Expanded(
                    child: Text(
                      'MIS CLASES',
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
              margin: EdgeInsets.only(left: 30, right: 30),
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
                          height: responsive.hp(7),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(color: Colors.black54),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40.0),
                                topLeft: Radius.circular(40.0)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'RESERVADA',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: responsive.dp(2.0),
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: responsive.width,
                          height: responsive.hp(7),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black54),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(40.0),
                                topRight: Radius.circular(40.0)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'ESPERA',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: responsive.dp(2.0),
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            dataHoraryStudent.toString() == '[a]'
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 100),
                      CircularProgressIndicator()
                    ],
                  )
                : dataHoraryStudent?.length == 0
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: responsive.hp(30)),
                Text('No se encontraron nuevos horarios reservados')
              ],
            )
                : Flexible(
                    child: ListView.builder(
                        itemCount: dataHoraryStudent?.length,
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
                                              dataHoraryStudent?[i]['clase']['nombre'],
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
                                                  dataHoraryStudent?[i]
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
                                          dataHoraryStudent?[i]['lugar']['nombre'],
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
                                              dataHoraryStudent?[i]['academia']
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
                                              dataHoraryStudent?[i]['cantidad']
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }))
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
