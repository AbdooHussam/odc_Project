import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserInformation extends ChangeNotifier {
  String fullName = "", phone = "", email = "", pass = "", address = "";
  String message_reg = "",
      message_login = "",
      status_login = "",
      message_vrification = "",
      status_vrification = "";

  String? access_token, refresh_token;
  late bool status_reg;
  String apiUrl = "https://d67c-196-205-94-85.eu.ngrok.io/api/v1";

  register() async {
   // String url = 'https://be03-196-205-94-85.eu.ngrok.io/api/v1/register';
    http.Response response = await http.post(
      Uri.parse("$apiUrl/registernew"),
      headers: <String, String>{
        'Content-Type': 'application/json; char=UTF-8',
      },
      body: jsonEncode(
        {
          'name': fullName,
          'email': email,
          'password': pass,
          'phone': phone,
          'address': address,
        },
      ),
    );

    var body = jsonDecode(response.body);
    status_reg = await body["success"];
    print(status_reg);
    message_reg = await body["message"];
    print(message_reg);
    notifyListeners();

    if (response.statusCode == 200) {
      print('Success =200 register ********************');
      print(body);
      if (status_reg == true) {
        access_token = await body["data"]["access_token"];
        refresh_token = await body["data"]["refresh_token"];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("access_token", access_token!);
        prefs.setString("refresh_token", refresh_token!);
      }
    } else {
      print('failed == 400 register ******************');
    }
  }

  login() async {
   // String url = 'https://be03-196-205-94-85.eu.ngrok.io/api/v1/login';
    http.Response response = await http.post(
      Uri.parse("$apiUrl/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; char=UTF-8',
      },
      body: jsonEncode(
        {
          'email': email,
          'password': pass,
        },
      ),
    );

    var body = jsonDecode(response.body);
    status_reg = await body["success"];
    print(status_reg);
    message_reg = await body["message"];
    print(message_reg);
    notifyListeners();

    if (response.statusCode == 200) {
      print('Success =200 login ********************');
      print(body);
      if (status_reg == true) {
        access_token = await body["data"]["access_token"];
        refresh_token = await body["data"]["refresh_token"];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("access_token", access_token!);
        prefs.setString("refresh_token", refresh_token!);
      }
    } else {
      print('failed == 400 login ******************');
    }
  }

  refreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    access_token = prefs.getString("access_token");
    refresh_token = prefs.getString("refresh_token");
   // String url = 'https://be03-196-205-94-85.eu.ngrok.io/api/v1/refreshToken';
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
      print('Success =200 refresh_token ********************');
      print(body);
      if (body["success"] == true) {
        access_token = await body["data"]["access_token"];
        refresh_token = await body["data"]["refresh_token"];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("access_token", access_token!);
        prefs.setString("refresh_token", refresh_token!);
      }
    } else {
      print('failed == 400 refresh_token ******************');
    }
    notifyListeners();
  }
}
