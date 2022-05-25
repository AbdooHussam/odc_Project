import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:odc/Provider/userInformation.dart';
import 'package:odc/Screens/Home/Courses/CourseDetails/CourseDetails_Controller.dart';
import 'package:odc/Screens/Home/Exam/Exam_Controller.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends ChangeNotifier {
  String? access_token, refresh_token;
  var apiUrl = UserInformation().apiUrl;

  String student_id = "",
      student_name = "",
      email = "",
      student_phone = "",
      student_address = "";

  bool status = false;

  getProfileDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    access_token = prefs.getString("access_token")!;
    try {
      http.Response response = await http.get(
        Uri.parse("$apiUrl/me"),
        headers: <String, String>{
          'Authorization': 'Bearer $access_token',
          'Content-Type': 'application/json; char=UTF-8',
        },
      );
      var body = json.decode(response.body);
      status = await body["success"];
      print(body["message"]);
      print(status);
      if (status == true) {
        student_address = body['data']["student"]["student_address"].toString();
        student_phone = body['data']["student"]["student_phone"].toString();
        email = body['data']["student"]["email"].toString();
        student_name = body['data']["student"]["student_name"].toString();
        student_id = body['data']["student"]["id"].toString();
      }

      notifyListeners();
    } catch (e) {
      print("$e getCourses ***************");
    }
  }

  logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    access_token = prefs.getString("access_token")!;
    try {
      http.Response response = await http.post(
        Uri.parse("$apiUrl/logout"),
        headers: <String, String>{
          'Authorization': 'Bearer $access_token',
          'Content-Type': 'application/json; char=UTF-8',
        },
      );

      var body = jsonDecode(response.body);
      print(body);

      status = body["success"];

      Fluttertoast.showToast(
        msg: body["message"],
        fontSize: 15,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 10,
      );
      print(body);
      notifyListeners();

      if (response.statusCode == 200) {
        print('Success =200 login ********************');
        print(body);
      } else {
        print('failed == 400 login ******************');
      }
    } catch (e) {
      print(e);
    }
  }
}
