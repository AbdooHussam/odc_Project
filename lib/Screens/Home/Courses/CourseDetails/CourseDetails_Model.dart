import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:odc/Provider/userInformation.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'CourseDetails_Controller.dart';

class CourseDetailsModel extends ChangeNotifier {
  String? access_token, refresh_token;
  var apiUrl =UserInformation().apiUrl;

  late bool status;

  String? course_name,
      category_name,
      courseId,
      catId,
      admin_name,
      course_level,
      admin_email;

  String message_enroll="";
  late bool status_enroll;

  List<CourseDetailsCard> coursDetails = [];

  getMoreCourses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    access_token = prefs.getString("access_token")!;
    String course_name, category_name, id, catId, admin_name;
    int lenth = 0;
    //String url = 'https://be03-196-205-94-85.eu.ngrok.io/api/v1/courses';
    try {
      http.Response response = await http.get(
        Uri.parse("$apiUrl/courses"),
        headers: <String, String>{
          'Authorization': 'Bearer $access_token',
          'Content-Type': 'application/json; char=UTF-8',
        },
      );
      var body = json.decode(response.body);

      lenth = body['data'].length;
      for (int i = 0; i < lenth; i++) {
        id = body['data'][i]['id'].toString();
        course_name = body['data'][i]['course_name'].toString();
        catId = body['data'][i]["Category"]['id'].toString();
        category_name = body['data'][i]["Category"]['category_name'].toString();
        admin_name = body['data'][i]["Admin"]['admin_name'].toString();

        coursDetails.add(CourseDetailsCard(
          id: id,
          course_name: course_name,
          category_name: category_name,
          admin_name: admin_name,
          catId: catId,
        ));
      }
      notifyListeners();
    } catch (e) {
      print("$e getCourses ***************");
      // refreshToken();
    }
  }

  getCoursesDetails() async {
    bool status;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    access_token = prefs.getString("access_token")!;
    try {
      http.Response response = await http.get(
        Uri.parse("$apiUrl/courses/${int.parse(courseId!)}"),
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
        courseId = body['data']["id"].toString();
        course_name = body['data']['course_name'].toString();
        course_level = body['data']['course_level'].toString();
        category_name = body['data']["Category"]['category_name'].toString();
        catId = body['data']["Category"]['id'].toString();
        admin_name = body['data']['Admin']["admin_name"].toString();
        admin_email = body['data']['Admin']["email"].toString();
      }

      notifyListeners();
    } catch (e) {
      print("$e getCourses ***************");
      //refreshToken();
    }
  }

  enrollCourse() async{
    http.Response response = await http.post(
      Uri.parse("$apiUrl/courses/${int.parse(courseId!)}/enroll"),
      headers: <String, String>{
        'Authorization': 'Bearer $access_token',
        'Content-Type': 'application/json; char=UTF-8',
      },
    );

    var body = jsonDecode(response.body);
    status_enroll = await body["success"];
    print(status_enroll);
    message_enroll = await body["message"];
    print(message_enroll);
    notifyListeners();

    if (response.statusCode == 200) {
      print('Success =200 login ********************');
      print(body);
    } else {
      print('failed == 400 login ******************');
    }
  }

}
