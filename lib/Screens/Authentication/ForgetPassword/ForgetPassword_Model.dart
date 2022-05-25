import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:odc/Provider/userInformation.dart';
import 'package:odc/Screens/Home/Courses/CourseDetails/CourseDetails_Controller.dart';
import 'package:odc/Screens/Home/Exam/Exam_Controller.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ForgetPassModel extends ChangeNotifier {
  var apiUrl = UserInformation().apiUrl;

  String email = "", otp = "", pass = "";
  bool status = false;
  bool rest_status = false;

  forgetPass() async {
    try {
      http.Response response = await http.post(
        Uri.parse("$apiUrl/forgetPassword"),
        headers: <String, String>{
          'Content-Type': 'application/json; char=UTF-8',
        },
        body: jsonEncode(
          {
            'email': email,
          },
        ),
      );

      var body = jsonDecode(response.body);
      print(body);

      // message_subExam = body["message"];
      status = body["success"];
      // subMark = body["data"]["userMark"];

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

  verifyOtp() async {
    try {
      http.Response response = await http.post(
        Uri.parse("$apiUrl/verifyOtp"),
        headers: <String, String>{
          'Content-Type': 'application/json; char=UTF-8',
        },
        body: jsonEncode(
          {'email': email, 'otp': otp},
        ),
      );

      var body = jsonDecode(response.body);
      print(body);

      // message_subExam = body["message"];
      status = body["success"];
      // subMark = body["data"]["userMark"];

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

  resetPass() async {
    try {
      http.Response response = await http.post(
        Uri.parse("$apiUrl/resetPassword"),
        headers: <String, String>{
          'Content-Type': 'application/json; char=UTF-8',
        },
        body: jsonEncode(
          {'email': email, 'otp': otp, "password": pass},
        ),
      );

      var body = jsonDecode(response.body);
      print(body);

      // message_subExam = body["message"];
      rest_status = body["success"];
      // subMark = body["data"]["userMark"];

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

// getCoursesDetails() async {
//   bool status;
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   access_token = prefs.getString("access_token")!;
//   try {
//     http.Response response = await http.get(
//       Uri.parse("$apiUrl/courses/${int.parse(courseId!)}"),
//       headers: <String, String>{
//         'Authorization': 'Bearer $access_token',
//         'Content-Type': 'application/json; char=UTF-8',
//       },
//     );
//     var body = json.decode(response.body);
//     status = await body["success"];
//     print(body["message"]);
//     print(status);
//     if (status == true) {
//       courseId = body['data']["id"].toString();
//       course_name = body['data']['course_name'].toString();
//       course_level = body['data']['course_level'].toString();
//       category_name = body['data']["Category"]['category_name'].toString();
//       catId = body['data']["Category"]['id'].toString();
//       admin_name = body['data']['Admin']["admin_name"].toString();
//       admin_email = body['data']['Admin']["email"].toString();
//     }
//
//     notifyListeners();
//   } catch (e) {
//     print("$e getCourses ***************");
//     //refreshToken();
//   }
// }
//
// enrollCourse() async {
//   http.Response response = await http.post(
//     Uri.parse("$apiUrl/courses/${int.parse(courseId!)}/enroll"),
//     headers: <String, String>{
//       'Authorization': 'Bearer $access_token',
//       'Content-Type': 'application/json; char=UTF-8',
//     },
//   );
//
//   var body = jsonDecode(response.body);
//   status_enroll = await body["success"];
//   print(status_enroll);
//   message_enroll = await body["message"];
//   print(message_enroll);
//   notifyListeners();
//
//   if (response.statusCode == 200) {
//     print('Success =200 login ********************');
//     print(body);
//   } else {
//     print('failed == 400 login ******************');
//   }
// }
}
