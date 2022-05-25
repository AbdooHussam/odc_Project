import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:odc/Provider/userInformation.dart';
import 'package:odc/Screens/Home/Courses/Courses_Controller.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../Home/Home_Controler.dart';

class CategoriesModel extends ChangeNotifier {
  String? access_token, refresh_token;
  var apiUrl =UserInformation().apiUrl;

  //String apiUrl = "https://5742-196-205-94-85.eu.ngrok.io/api/v1";
  String catId="",category_name="";

  late bool status;

  List<CategoriesCard> categList = [];
  List<AllCoursesCard> catDetails = [];

  getCategories({bool allCat = false}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    access_token = prefs.getString("access_token");
    refresh_token = prefs.getString("refresh_token");
    print(access_token);
    print(refresh_token);
    String name = "", image = "", id = "";
    int lenth = 0;
    try {
      http.Response response = await http.get(
        Uri.parse("$apiUrl/categories"),
        headers: <String, String>{
          'Authorization': 'Bearer $access_token',
          'Content-Type': 'application/json; char=UTF-8',
        },
      );
      var body = json.decode(response.body);
      if (allCat == true) {
        lenth = body['data'].length;
      } else {
        if (body['data'].length > 3) {
          lenth = 3;
        } else {
          lenth = body['data'].length;
        }
      }

      for (int i = 0; i < lenth; i++) {
        id = body['data'][i]['id'].toString();
        name = body['data'][i]['category_name'];
        image = body['data'][i]['image_url'];

        categList.add(CategoriesCard(
          image: image,
          name: name,
          catId: id,
        ));
      }
      notifyListeners();
    } catch (e) {
      print("$e getCategories *************************");
      refreshToken();
    }
  }

  getCategoriesDetails() async {
    String course_name, id,catId2, admin_name;
    catId2=catId;
    int lenth = 0;
    bool status;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    access_token = prefs.getString("access_token")!;
    try {
      http.Response response = await http.get(
        Uri.parse("$apiUrl/categories/${int.parse(catId)}/courses"),
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
        lenth = body['data']['Courses'].length;
        for (int i = 0; i < lenth; i++) {
          id = body['data']['Courses'][i]["id"].toString();
          course_name = body['data']['Courses'][i]['course_name'].toString();
          // course_level = body['data']['Courses'][0]['course_level'].toString();
          category_name = body['data']['category_name'].toString();
          admin_name =
              body['data']['Courses'][i]['Admin']["admin_name"].toString();
          //admin_email = body['data']['Courses'][0]['Admin']["email"].toString();

          catDetails.add(AllCoursesCard(
            id: id,
            course_name: course_name,
            category_name: category_name,
            admin_name: admin_name,
            catId: catId2,
          ));
        }
      }

      notifyListeners();
    } catch (e) {
      print("$e getCourses ***************");
      //refreshToken();
    }
  }

  refreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    access_token = prefs.getString("access_token");
    refresh_token = prefs.getString("refresh_token");
    //String url = 'https://be03-196-205-94-85.eu.ngrok.io/api/v1/refreshToken';
    http.Response response = await http.post(
      Uri.parse("$apiUrl/refreshToken"),
      headers: <String, String>{
        'Authorization': 'Bearer $refresh_token',
        'Content-Type': 'application/json; char=UTF-8',
      },
    );

    var body = jsonDecode(response.body);
    print(body["success"]);
    print(body["message"]);
    notifyListeners();

    if (response.statusCode == 200) {
      print('Success =200 refreshToken ********************');
      print(body);
      if (body["success"] == true) {
        access_token = await body["data"]["access_token"];
        refresh_token = await body["data"]["refresh_token"];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("access_token", access_token!);
        prefs.setString("refresh_token", refresh_token!);
      }
    } else {
      print('failed == 400 refreshToken ******************');
    }
    getCategories();
    notifyListeners();
  }
}
