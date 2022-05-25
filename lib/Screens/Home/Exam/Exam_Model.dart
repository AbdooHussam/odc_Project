import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:odc/Provider/userInformation.dart';
import 'package:odc/Screens/Home/Courses/CourseDetails/CourseDetails_Controller.dart';
import 'package:odc/Screens/Home/Exam/Exam_Controller.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ExamModel extends ChangeNotifier {
  var apiUrl = UserInformation().apiUrl;

  String? access_token, refresh_token;

  String courseName = "";

  String courseCode = "";

  String message_getExam = "";
  late bool status_getExam;

  List<questionCard> examCard = [];

  List<String> userAnswer = [];

  int currentQuestion = 0;
  bool nextQ = true;

  Object? radioValue = 0;

  nextQuestion() {
    if (currentQuestion < examCard.length) {
      currentQuestion++;
      radioValue = 0;
      nextQ = true;
      notifyListeners();
    } else {
      nextQ = false;
      radioValue = 0;
      notifyListeners();
    }
    notifyListeners();
  }

  getExam() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    access_token = prefs.getString("access_token")!;
    String question_id,
        question,
        question_mark,
        answer_1,
        answer_2,
        answer_3,
        answer_4,
        correct_answer,
        exam_id;
    int lenth = 0;

    try {
      http.Response response = await http.get(
        Uri.parse("$apiUrl/exams/${int.parse(courseCode)}"),
        headers: <String, String>{
          'Authorization': 'Bearer $access_token',
          'Content-Type': 'application/json; char=UTF-8',
        },
      );
      var body = json.decode(response.body);

      message_getExam = body['message'];
      status_getExam = body['success'];

      lenth = body['data'].length;
      for (int i = 0; i < lenth; i++) {
        question_id = body['data'][i]['id'].toString();
        question = body['data'][i]['question'].toString();
        question_mark = body['data'][i]["question_mark"].toString();
        answer_1 = body['data'][i]["answer_1"].toString();
        answer_2 = body['data'][i]["answer_2"].toString();
        answer_3 = body['data'][i]["answer_3"].toString();
        answer_4 = body['data'][i]["answer_4"].toString();
        correct_answer = body['data'][i]["correct_answer"].toString();
        exam_id = body['data'][i]["exam_id"].toString();

        examCard.add(questionCard(
          answer_1: answer_1,
          answer_2: answer_2,
          answer_3: answer_3,
          answer_4: answer_4,
          correct_answer: correct_answer,
          question: question,
          question_mark: question_mark,
          exam_id: exam_id,
          question_id: question_id,
        ));
      }
      notifyListeners();
    } catch (e) {
      print("$e getCourses ***************");
      // refreshToken();
    }
    notifyListeners();
  }

  submitExam() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    access_token = prefs.getString("access_token")!;
    try {
      http.Response response = await http.post(
        Uri.parse("$apiUrl/exams/${int.parse(courseCode)}/submit"),
        headers: <String, String>{
          'Authorization': 'Bearer $access_token',
          'Content-Type': 'application/json; char=UTF-8',
        },
        body: jsonEncode(
          {
            'answers': userAnswer,
          },
        ),
      );

      var body = jsonDecode(response.body);

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
