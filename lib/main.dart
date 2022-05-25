import 'package:flutter/material.dart';
import 'package:odc/Screens/Authentication/ForgetPassword/ForgetPassword_View.dart';
import 'package:odc/Screens/Home/Courses/CourseDetails/CourseDetails_Model.dart';
import 'package:odc/Screens/Home/Exam/Exam_Model.dart';
import 'package:odc/Screens/Home/Home/Home_Model.dart';
import 'package:odc/Screens/Home/Home/NavBar_Screen.dart';
import 'package:odc/SplashScreen.dart';
import 'package:provider/provider.dart';
import 'Provider/userInformation.dart';
import 'Screens/Authentication/ForgetPassword/ForgetPassword_Model.dart';
import 'Screens/Home/Categories/Categories_Model.dart';
import 'Screens/Home/Exam/Interview_course result/HrInterview_View.dart';
import 'Screens/Home/MyProfile/Profile_Model.dart';
import 'Screens/Home/MyProfile/Profile_View.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserInformation>(
            create: (context) => UserInformation()),
        ChangeNotifierProvider<HomeModel>(create: (context) => HomeModel()),
        ChangeNotifierProvider<CategoriesModel>(
            create: (context) => CategoriesModel()),
        ChangeNotifierProvider<CourseDetailsModel>(
            create: (context) => CourseDetailsModel()),
        ChangeNotifierProvider<ExamModel>(create: (context) => ExamModel()),
        ChangeNotifierProvider<ForgetPassModel>(create: (context) => ForgetPassModel()),
        ChangeNotifierProvider<Profile>(create: (context) => Profile()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            unselectedWidgetColor: Color(0xFFFF6600)),
        home: SplashPage(),
      ),
    );
  }
}
