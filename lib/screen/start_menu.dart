
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:limitless/screen/calendar/calendar_screen.dart';
import 'package:limitless/screen/home/home_screen.dart';
import 'package:limitless/screen/message/message_screen.dart';
import 'package:limitless/util/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TabUserWidget extends StatefulWidget {
  int? page;
  TabUserWidget({Key? key, this.page}) : super(key: key);
  @override
  _TabUserWidgetState createState() => _TabUserWidgetState();
}

class _TabUserWidgetState extends State<TabUserWidget> {
  GlobalKey _bottomNavigationKey = GlobalKey();
  initState() {
    super.initState();
    /*final pushProvider = new PushNotificationProvider();
    pushProvider.initNotifications();
    pushProvider.mensajes.listen((argumento) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return NotificationPage(argumento: argumento,);
          },useRootNavigator: false,
          barrierDismissible: false
      );
    });*/
  }

  _selectTab(int pos) {
    switch (pos) {
      case 0:
        return CalendarScreen();
      case 1:
        return HomeScreen();
      case 2:
        return MessageScreen();
      default:
        return Text("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive.of(context);
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
                bottomNavigationBar: CurvedNavigationBar(
                  key: _bottomNavigationKey,
                  index: widget.page!,
                  height: 70.0,
                  items: <Widget>[
                    Icon(Icons.calendar_month_outlined, size: 30, color: Colors.white,),
                    Icon(Icons.home_outlined, size: 30, color: Colors.white,),
                    Icon(Icons.local_activity_outlined, size: 30, color: Colors.white,),
                  ],
                  color: Colors.black,
                  buttonBackgroundColor: Colors.blueAccent,
                  backgroundColor: Colors.transparent,
                  animationCurve: Curves.easeInOut,
                  animationDuration: Duration(milliseconds: 500),
                  onTap: (index) {
                    setState(() {
                      widget.page = index;
                    });
                  },
                ),
                body: _selectTab(widget.page!)
            )
        )
    );
  }
}