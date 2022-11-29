import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:limitless/screen/start_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Services {
  int connectTimeout = 100000;
  int receiveTimeout = 100000;
  Dio dio = Dio();
  String url = "https://backend-limitless-test.herokuapp.com";

  Future login(String email, String password, BuildContext context) async {
    dio.options.connectTimeout = connectTimeout;
    dio.options.receiveTimeout = receiveTimeout;
    final prefs = await SharedPreferences.getInstance();
    final data = {
      "correo": email,
      "password": password,
    };
    try {
      final response = await dio.post(
        '$url/api/login',
        data: data,
      );
      print("CODIGO DE RESPUESTA");
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('========== login =========');
        print(response.data['id']);
        await prefs.setString(
            'idUserLimitless', response.data['id'].toString());

        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacement(PageRouteBuilder(
              pageBuilder: (BuildContext context, _, __) {
            return TabUserWidget(
              page: 1,
            );
          }, transitionsBuilder:
                  (_, Animation<double> animation, __, Widget child) {
            return FadeTransition(opacity: animation, child: child);
          }));
        });
      }
    } on DioError catch (e) {
      print("-------ERROR------");
      print(e.response?.statusCode = 400);
      if (e.response?.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.response?.data['error'],
              style: const TextStyle(color: Colors.white)),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text('error del servidor', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ));
      }
    }
  }

  Future<List?> ListHoraryAll() async {
    dio.options.connectTimeout = connectTimeout;
    dio.options.receiveTimeout = receiveTimeout;
    String? idUser;
    //final prefs = await SharedPreferences.getInstance();
    //idUser = prefs.getString('idUserLimitless');
    //final data = {"patient_idpatient": idUser};
    try {
      final response = await dio.get(url + '/api/horario_adelante');
      if (response.statusCode == 200) {
        print("datos de api");
        print(response.data.toString());
        return response.data;
      }
    } catch (err) {
      print(err);
      return [];
    }
  }

  Future<List?> HoraryStudent() async {
    dio.options.connectTimeout = connectTimeout;
    dio.options.receiveTimeout = receiveTimeout;
    String? idUser;
    final prefs = await SharedPreferences.getInstance();
    idUser = prefs.getString('idUserLimitless');
    try {
      final response = await dio.get(url + '/api/horario-alumno/alumno/$idUser');
      if (response.statusCode == 200) {
        print("datos de api");
        print(response.data.toString());
        return response.data['horarios'];
      }
    } catch (err) {
      print(err);
      return [];
    }
  }

  Future<List?> HoraryDetail(String? idUser) async {
    dio.options.connectTimeout = connectTimeout;
    dio.options.receiveTimeout = receiveTimeout;
    try {
      final response = await dio.get(url + '/api/horario-alumno/horario/$idUser');
      if (response.statusCode == 200) {
        print("datos de api");
        print(response.data.toString());
        return [response.data];
      }
    } catch (err) {
      print(err);
      return [];
    }
  }

  Future<List?> MessageUser() async {
    dio.options.connectTimeout = connectTimeout;
    dio.options.receiveTimeout = receiveTimeout;
    String? idUser;
    final prefs = await SharedPreferences.getInstance();
    idUser = prefs.getString('idUserLimitless');
    try {
      final response = await dio.get(url +'/api/mensaje/receptor/$idUser');
      if (response.statusCode == 200) {
        print("datos de api");
        print(response.data.toString());
        return response.data;
      }
    } catch (err) {
      print(err);
      return [];
    }
  }

  Future<List?> ListHoraryDate(String date) async {
    dio.options.connectTimeout = connectTimeout;
    dio.options.receiveTimeout = receiveTimeout;
    final data = {"fechaInicio": date, "fechaFin": date};
    try {
      final response = await dio.post(url + '/api/horario_fecha', data: data);
      if (response.statusCode == 200) {
        print("datos de api");
        print(response.data.toString());
        return response.data;
      }
    } catch (err) {
      print(err);
      return [];
    }
  }

  // @override
  // Future<DoctorModel?> loginDoctor(
  //     String typeUser, String email, String password) async {
  //   dio.options.connectTimeout = connectTimeout;
  //   dio.options.receiveTimeout = receiveTimeout;
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.remove("linkscrennvalidation");
  //   await prefs.setString('linkscrennvalidation', 'Start');
  //   final data = {
  //     "email": email,
  //     "password": password,
  //   };
  //   try {
  //     final response = await dio.post(
  //       url + '/loginDoctor',
  //       data: data,
  //     );
  //     print("CODIGO DE RESPUESTA");
  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       print("datos");
  //       print(response.data.toString());
  //       //List<dynamic> data = response.data;
  //       print("------datos-------");
  //       //print(data);
  //       Map<String, dynamic> jsonInfo = response.data;
  //       print(jsonInfo);
  //       String shared =
  //           "{iddoctor: ${jsonInfo["iddoctor"].toString()}, name: ${jsonInfo["name"].toString()}, last_name: ${jsonInfo["last_name"].toString()}, speciality: ${jsonInfo["speciality"].toString()}, profile_picture: ${jsonInfo["profile_picture"].toString()}, password: ${jsonInfo["password"].toString()}, token_push: ${jsonInfo["token_push"].toString()}, date_modified: , email: ${jsonInfo["email"].toString()}, active: ${jsonInfo["active"].toString()}, video_help_idvideo_help: ${jsonInfo["video_help_idvideo_help"].toString()}, blocked_schedule_idblocked_schedule: ${jsonInfo["blocked_schedule_idblocked_schedule"].toString()}, type_profile_idtype_profile: ${jsonInfo["type_profile_idtype_profile"].toString()}, status_tutorial: ${jsonInfo["status_tutorial"].toString()}}";
  //       await prefs.setString('linkDataDoctor', shared);
  //       await prefs.setString('linkIdDoctor', jsonInfo["iddoctor"].toString());
  //       DoctorModel infoDoctorObject = DoctorModel.fromJson(jsonInfo);
  //       print("-------------------doctorrrrrr------------------");
  //       print(infoDoctorObject.toString());
  //       print(infoDoctorObject.name);
  //       return infoDoctorObject;
  //     }
  //   } catch (err) {
  //     print(err);
  //     return null;
  //   }
  //   throw UnimplementedError();
  // }
  //
  // @override
  // Future<bool> forgotPasswordEmail(String email) async {
  //   dio.options.connectTimeout = connectTimeout;
  //   dio.options.receiveTimeout = receiveTimeout;
  //   final data = {
  //     "email": email,
  //   };
  //   try {
  //     final response = await dio.put(
  //       url + '/updatePasswordEmail',
  //       data: data,
  //     );
  //     print("CODIGO DE RESPUESTA");
  //     print(response.statusCode);
  //
  //     if (response.statusCode == 200) {
  //       print(response.data[0]["password"]);
  //       final data2 = {
  //         "sender": {"name": "Sounca", "email": "souncadev@gmail.com"},
  //         "to": [
  //           {
  //             "email": response.data[0]["email"],
  //             "name": response.data[0]["name"],
  //           }
  //         ],
  //         "templateId": 1,
  //         "params": {
  //           "name": response.data[0]["name"],
  //           "password": response.data[0]["password"]
  //         },
  //         "headers": {
  //           "X-Mailin-custom":
  //               "custom_header_1:custom_value_1|custom_header_2:custom_value_2|custom_header_3:custom_value_3",
  //           "charset": "iso-8859-1"
  //         }
  //       };
  //       print(data2);
  //       final response2 = await dio.post(
  //         'https://api.sendinblue.com/v3/smtp/email',
  //         data: data2,
  //         options: Options(headers: {
  //           "api-key":
  //               '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'
  //         }),
  //       );
  //       print("CODIGO DE RESPUESTA");
  //       print(response2.statusCode);
  //       if (response2.statusCode == 201) {
  //         return true;
  //       } else {
  //         return false;
  //       }
  //     } else {
  //       return false;
  //     }
  //   } catch (err) {
  //     print(err);
  //     return false;
  //   }
  // }
  //
  // @override
  // Future<bool> forgotPasswordNumber(String phone) async {
  //   dio.options.connectTimeout = connectTimeout;
  //   dio.options.receiveTimeout = receiveTimeout;
  //   final data = {
  //     "phone": phone,
  //   };
  //   print(data);
  //   try {
  //     final response = await dio.put(
  //       url + '/updatePasswordSms',
  //       data: data,
  //     );
  //     print("CODIGO DE RESPUESTA");
  //     print(response.statusCode);
  //
  //     if (response.statusCode == 200) {
  //       print(response.data["password"]);
  //       final data2 = {
  //         "To": int.parse(response.data["phone"].toString()),
  //         "MessagingServiceSid": "MG6bfb7089b68fe257bbbc18bdd1fb9acf",
  //         "Body": "Tu nueva contraseña es : " + response.data["password"],
  //         "from": "Sounca"
  //       };
  //       print(data2);
  //       final response2 = await dio.post(
  //         'https://api.twilio.com/2010-04-01/Accounts/AC99123d9b810e352d7d63f335591642c7/Messages.json',
  //         data: data2,
  //         options: Options(headers: {
  //           "Authorization":
  //               "Basic QUM5OTEyM2Q5YjgxMGUzNTJkN2Q2M2YzMzU1OTE2NDJjNzo4MDk1YjNmOTY2NGQzNzI1YjUwYjI0NzU5MWE0NjRlYg==",
  //           "Content-Type": "application/x-www-form-urlencoded",
  //         }),
  //       );
  //       print("CODIGO DE RESPUESTA");
  //       print(response2.statusCode);
  //       if (response2.statusCode == 201) {
  //         return true;
  //       } else {
  //         return false;
  //       }
  //     } else {
  //       return false;
  //     }
  //   } catch (err) {
  //     print(err);
  //     return false;
  //   }
  // }
  //
  // @override
  // Future<bool> PopupVerification(String type) async {
  //   dio.options.connectTimeout = connectTimeout;
  //   dio.options.receiveTimeout = receiveTimeout;
  //   String? idUser;
  //   String? idDoctor;
  //   final prefs = await SharedPreferences.getInstance();
  //   idUser = prefs.getString('linkIdUser');
  //   idDoctor = prefs.getString('linkIdDoctor');
  //   final data = {
  //     "type": int.parse(type), //1 = perfil doctor , 2= patient
  //     "id": type == "1"
  //         ? int.parse(idDoctor ?? "")
  //         : idUser, //id  doctor or patient
  //     "status_tutorial": 1 // 1 =  video visto
  //   };
  //   print(data);
  //   try {
  //     final response = await dio.put(
  //       url + '/updateStatusTutorial',
  //       data: data,
  //     );
  //     print("statusTutorial");
  //     print(response.statusCode);
  //
  //     if (response.statusCode == 200) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (err) {
  //     print(err);
  //     return false;
  //   }
  // }
  //
  // Future<void> logout(BuildContext context) async {
  //   final prefs = await SharedPreferences.getInstance();
  //
  //   await prefs.remove('linkIdUser');
  //   await prefs.remove('linkIdDoctor');
  //   await prefs.remove('linkDataUser');
  //   await prefs.remove('linkDataDoctor');
  //   await prefs.remove('linkCheckVerification');
  //   SignInScreen().launch(context,
  //       isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade);
  // }
  //
  // @override
  // Future<List<dynamic>> appointmentPatient() async {
  //   dio.options.connectTimeout = connectTimeout;
  //   dio.options.receiveTimeout = receiveTimeout;
  //   String? idUser;
  //   final prefs = await SharedPreferences.getInstance();
  //   idUser = prefs.getString('linkIdUser');
  //   print(idUser);
  //   final data = {"patient_idpatient": int.parse(idUser.toString())};
  //   try {
  //     final response = await dio.post(url + '/listAppointment', data: data);
  //     print("RESPUESTA APPOINTMENT");
  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       print("datos de api");
  //       print(response.data.toString());
  //       print("------datos-------");
  //       List<dynamic> jsonInfo = response.data;
  //       print(jsonInfo);
  //       return jsonInfo;
  //     }
  //   } catch (err) {
  //     print(err);
  //     return [];
  //   }
  //
  //   throw UnimplementedError();
  // }
  //

  //
  // @override
  // Future<List<dynamic>> VideoPatient() async {
  //   dio.options.connectTimeout = connectTimeout;
  //   dio.options.receiveTimeout = receiveTimeout;
  //   try {
  //     final response = await dio.get(
  //       url + '/listVideosHelp',
  //     );
  //     print("RESPUESTA VideoPatient");
  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       print("datos de api");
  //       print(response.data.toString());
  //       print("------datos-------");
  //       List<dynamic> jsonInfo = response.data;
  //       print(jsonInfo);
  //       return jsonInfo;
  //     }
  //   } catch (err) {
  //     print(err);
  //     return [];
  //   }
  //   throw UnimplementedError();
  // }
  //
  // @override
  // Future<List<dynamic>> appointmentDoctor() async {
  //   dio.options.connectTimeout = connectTimeout;
  //   dio.options.receiveTimeout = receiveTimeout;
  //   String? idDoctor;
  //   final prefs = await SharedPreferences.getInstance();
  //   idDoctor = prefs.getString('linkIdDoctor');
  //   final data = {"doctor_iddoctor": idDoctor};
  //   try {
  //     final response =
  //         await dio.post(url + '/listAppointmentDoctor', data: data);
  //     print("RESPUESTA APPOINTMENT");
  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       print("datos de api");
  //       print(response.data.toString());
  //       print("------datos-------");
  //       List<dynamic> jsonInfo = response.data;
  //       print(jsonInfo);
  //       return jsonInfo;
  //     }
  //   } catch (err) {
  //     print(err);
  //     return [];
  //   }
  //
  //   throw UnimplementedError();
  // }
  //
  // @override
  // Future<List<dynamic>> MyHistoryDoctor() async {
  //   dio.options.connectTimeout = connectTimeout;
  //   dio.options.receiveTimeout = receiveTimeout;
  //   String? idDoctor;
  //   final prefs = await SharedPreferences.getInstance();
  //   idDoctor = prefs.getString('linkIdDoctor');
  //   final data = {"doctor_iddoctor": idDoctor};
  //   try {
  //     final response =
  //         await dio.post(url + '/listAppointmentHistoryDoctor', data: data);
  //     print("RESPUESTA MyHistory");
  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       print("datos de api");
  //       print(response.data.toString());
  //       print("------datos-------");
  //       List<dynamic> jsonInfo = response.data;
  //       print(jsonInfo);
  //       return jsonInfo;
  //     }
  //   } catch (err) {
  //     print(err);
  //     return [];
  //   }
  //   throw UnimplementedError();
  // }
  //
  // @override
  // Future<bool> newAppointment(String diagnose) async {
  //   dio.options.connectTimeout = connectTimeout;
  //   dio.options.receiveTimeout = receiveTimeout;
  //   String? idPatient;
  //   final prefs = await SharedPreferences.getInstance();
  //   idPatient = prefs.getString('linkIdUser');
  //   final data = {
  //     "diagnose": diagnose,
  //     "symtomps": '',
  //     "patient_idpatient": int.parse(idPatient.toString()),
  //     "prescription": ''
  //   };
  //   print(data);
  //   try {
  //     final response = await dio.post(url + '/createAppointment', data: data);
  //     print("RESPUESTA NewApointment");
  //     print(response.data);
  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       return true;
  //     }
  //   } catch (err) {
  //     print(err);
  //     return false;
  //   }
  //   throw UnimplementedError();
  // }
  //
  // @override
  // Future<List?> ListSubpatient() async {
  //   dio.options.connectTimeout = connectTimeout;
  //   dio.options.receiveTimeout = receiveTimeout;
  //   String? idUser;
  //   final prefs = await SharedPreferences.getInstance();
  //   idUser = prefs.getString('linkIdUser');
  //   try {
  //     final response = await dio.get(
  //       url + '/listSubPatient/$idUser',
  //     );
  //     print("RESPUESTA VideoPatient");
  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       print("datos de api");
  //       print(response.data.toString());
  //       return response.data;
  //     }
  //   } catch (err) {
  //     print(err);
  //     return [];
  //   }
  // }
  //
  // @override
  // Future<bool?> CreateFamily(
  //     String name,
  //     String lastname,
  //     String phone,
  //     String age,
  //     String birth_date,
  //     String blood_type,
  //     String address,
  //     String weight,
  //     String height,
  //     String sexo,
  //     String diseases,
  //     String allergies,
  //     String picture) async {
  //   dio.options.connectTimeout = connectTimeout;
  //   dio.options.receiveTimeout = receiveTimeout;
  //   String? idUser;
  //   final prefs = await SharedPreferences.getInstance();
  //   idUser = prefs.getString('linkIdUser');
  //   final data = {
  //     "name": name,
  //     "lastname": lastname,
  //     "phone": phone,
  //     "age": age,
  //     "birth_date": birth_date,
  //     "blood_type": blood_type,
  //     "address": address,
  //     "weight": weight,
  //     "idpatient": int.parse(idUser.toString()),
  //     "height": height,
  //     "sexo": sexo,
  //     "diseases": diseases,
  //     "allergies": allergies,
  //     "picture": picture
  //   };
  //   try {
  //     final response = await dio.post(url + '/createSubPatient', data: data);
  //     print("RESPUESTA createSubPatient");
  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       print("datos de api");
  //       print(response.data.toString());
  //       return true;
  //     }
  //   } catch (err) {
  //     print(err);
  //     return false;
  //   }
  // }
  //
  // @override
  // Future<bool?> UpdateFamily(
  //     String idProfile,
  //     String name,
  //     String lastname,
  //     String phone,
  //     String age,
  //     String birth_date,
  //     String blood_type,
  //     String address,
  //     String weight,
  //     String height,
  //     String sexo,
  //     String diseases,
  //     String allergies,
  //     String picture) async {
  //   dio.options.connectTimeout = connectTimeout;
  //   dio.options.receiveTimeout = receiveTimeout;
  //   final data;
  //   if (picture == '') {
  //     data = {
  //       "name": name,
  //       "lastname": lastname,
  //       "phone": phone,
  //       "age": age,
  //       "birth_date": birth_date,
  //       "blood_type": blood_type,
  //       "address": address,
  //       "weight": weight,
  //       "idpatient": int.parse(idProfile),
  //       "height": height,
  //       "sexo": sexo,
  //       "diseases": diseases,
  //       "allergies": allergies,
  //       "profile_picture": null
  //     };
  //   } else {
  //     data = {
  //       "name": name,
  //       "lastname": lastname,
  //       "phone": phone,
  //       "age": age,
  //       "birth_date": birth_date,
  //       "blood_type": blood_type,
  //       "address": address,
  //       "weight": weight,
  //       "idpatient": int.parse(idProfile),
  //       "height": height,
  //       "sexo": sexo,
  //       "diseases": diseases,
  //       "allergies": allergies,
  //       "picture": picture
  //     };
  //   }
  //   try {
  //     final response = await dio.post(url + '/updatePatientMobile', data: data);
  //     print("RESPUESTA createSubPatient");
  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       print("datos de api");
  //       print(response.data.toString());
  //       return true;
  //     }
  //   } catch (err) {
  //     print(err);
  //     return false;
  //   }
  // }
  //
  // @override
  // Future<bool?> SavePatientDisease(
  //     List questions, String SelectPatientName, List test) async {
  //   dio.options.connectTimeout = connectTimeout;
  //   dio.options.receiveTimeout = receiveTimeout;
  //   String? SelectPatientId;
  //   final prefs = await SharedPreferences.getInstance();
  //   SelectPatientId = prefs.getString('SelectPatientId');
  //   final data = {
  //     "idpatient": int.parse(SelectPatientId.toString()),
  //     "disease_name": SelectPatientName,
  //     "questions": questions,
  //     "tests": test
  //   };
  //   print('============== FFFFFFFFFFF =============');
  //   print(int.parse(SelectPatientId.toString()));
  //   print(data);
  //   try {
  //     final response = await dio.post(url + '/savePatientDisease', data: data);
  //     print("RESPUESTA createSubPatient");
  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       print("respuesta");
  //       print(response.data.toString());
  //       return true;
  //     }
  //   } catch (err) {
  //     print(err);
  //     return false;
  //   }
  // }
}
