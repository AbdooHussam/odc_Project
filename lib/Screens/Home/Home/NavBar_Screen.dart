import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:odc/Screens/Authentication/Login/Login_View.dart';
import 'package:odc/Screens/Authentication/SignUp/signUp_View.dart';
import 'package:odc/Screens/Home/Courses/Courses_View.dart';
import 'package:odc/Screens/Home/Home/Home_View.dart';
import 'package:odc/Screens/Home/MyProfile/Profile_View.dart';
import 'package:provider/provider.dart';

class Nav_Home extends StatefulWidget {
  @override
  _Nav_HomeState createState() => _Nav_HomeState();
}

class _Nav_HomeState extends State<Nav_Home> {
  int nav_index = 0;

  // Future? _future;
  //
  // Future<void> prepareData() async {
  //   var access = Provider.of<Api>(context, listen: false);
  //   await access.getAccess();
  // }
  //
  // @override
  // void initState() {
  //   _future = prepareData();
  //   super.initState();
  // }
  //
  final screens = [
    const HomeScreen(),
    const NewCoursesScreen(appBar: "My Courses"),
     ProfileDetailsScreen(),
  ];


  void _changeItem(int value) {
    print(value);
    setState(() {
      nav_index = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: screens[nav_index],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.house,size: 20), label: "⦿"),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.bookOpen,size: 20), label: "⦿"),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, size: 25),
              label: "⦿",
            ),
          ],
          currentIndex: nav_index,
          onTap: _changeItem,
          selectedItemColor: const Color(0xFFFF6600),
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w900,fontSize: 10,
            color: const Color(0xFFFF6600),
          ),
          showUnselectedLabels: false,
        ),
      ),
    );
  }
}
