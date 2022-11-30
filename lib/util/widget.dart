import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

alertMessageReserve(context, String mail) {

  var alertStyle = AlertStyle(
      titleStyle: TextStyle(color: Colors.black),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      isCloseButton: false);
  return Alert(
      style: alertStyle,
      context: context,
      //title: "",
      onWillPopActive: true,
      content: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.green, width: 2)),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_alert,
                            color: Colors.green,
                            size: 20,
                          )
                        ]),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Mensaje importante',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  )
                ]),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    mail,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      buttons: [
        DialogButton(
          height: 55,
          color: Colors.black87,
          radius: BorderRadius.circular(40.0),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: Text(
              "Entendido",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ]).show();
}