import 'package:flutter/material.dart';
import 'package:limitless/screen/home/class_reservation_screen.dart';
import 'package:limitless/service/services.dart';
import 'package:limitless/util/responsive.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List? dataMessage = ['a'];

  loadUser() async {
    dataMessage = await Services().MessageUser();
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
                    'MENSAJE',
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
          dataMessage.toString() == '[a]'
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: responsive.hp(30)),
                    CircularProgressIndicator()
                  ],
                )
              : dataMessage?.length == 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: responsive.hp(30)),
                        Text('No se encontraron nuevos mensajes.')
                      ],
                    )
                  : Flexible(
                      child: ListView.builder(
                      itemCount: dataMessage?.length,
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
                                  border: Border.all(color: Colors.black54),
                                  color: Colors.transparent,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            dataMessage?[i]['titulo'],
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: responsive.dp(2.0),
                                                fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.center,
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
                                            dataMessage?[i]['descripcion'],
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: responsive.dp(2.0),
                                                fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.start,
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
                      },
                    ))
        ],
      ),
    );
  }
}
