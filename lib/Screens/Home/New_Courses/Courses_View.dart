import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../Home_Model.dart';
import '../Home_View.dart';

class NewCoursesScreen extends StatefulWidget {
  @override
  _NewCoursesScreenState createState() => _NewCoursesScreenState();
}

class _NewCoursesScreenState extends State<NewCoursesScreen> {
  bool showSpinner = false;

  late Future _future;

  Future<void> prepareData() async {
    var get_Courses = Provider.of<HomeModel>(context, listen: false);
    (get_Courses.allCoursesCard.isEmpty)
        ? await get_Courses.getCourses(allCourses: true)
        : null;
  }

  @override
  void initState() {
    _future = prepareData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var getCourses = Provider.of<HomeModel>(context);
    return WillPopScope(
      onWillPop: () async {
        getCourses.allCoursesCard.clear();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
            ModalRoute.withName('/'));
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text("New Courses",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                )),
            centerTitle: true,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  getCourses.allCoursesCard.clear();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => HomeScreen()),
                      ModalRoute.withName('/'));
                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: (context) => HomeScreen()));
                }),
          ),
          body: (getCourses.allCoursesCard.isEmpty)
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  // padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                  itemCount: getCourses.allCoursesCard.length,
                  itemBuilder: (context, index) {
                    return getCourses.allCoursesCard[index];
                  })),
    );
  }
}
