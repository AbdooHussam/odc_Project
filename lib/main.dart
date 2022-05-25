import 'package:flutter/material.dart';
import 'package:odc/Screens/Home/Courses/CourseDetails/CourseDetails_Model.dart';
import 'package:odc/Screens/Home/Exam/Exam_Model.dart';
import 'package:odc/Screens/Home/Home/Home_Model.dart';
import 'package:odc/Screens/Home/Home/NavBar_Screen.dart';
import 'package:odc/SplashScreen.dart';
import 'package:provider/provider.dart';
import 'Provider/userInformation.dart';
import 'Screens/Home/Categories/Categories_Model.dart';

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
