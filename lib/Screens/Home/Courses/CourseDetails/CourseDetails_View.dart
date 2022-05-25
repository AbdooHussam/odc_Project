import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:odc/Screens/Home/Exam/Exam_Model.dart';
import 'package:odc/Screens/Home/Exam/Exam_View.dart';
import 'package:odc/Screens/Home/Exam/FirstPage_View.dart';
import 'package:provider/provider.dart';

import 'CourseDetails_Model.dart';

class CourseDetailsScreen extends StatefulWidget {
  const CourseDetailsScreen({
    Key? key,
    required this.courseId,
  }) : super(key: key);
  final String courseId;

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  late Future _future;

  TextEditingController courseCode = TextEditingController();
  final _key = GlobalKey<FormState>();

  bool emailSend = false;

  Future<void> prepareData() async {
    var cours = Provider.of<CourseDetailsModel>(context, listen: false);
    (cours.coursDetails.isEmpty) ? await cours.getMoreCourses() : null;
  }

  @override
  void initState() {
    _future = prepareData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cDetails = Provider.of<CourseDetailsModel>(context);
    var exam = Provider.of<ExamModel>(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(17),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .265,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/mobile2.png'),
                          fit: BoxFit.fill)),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 51,
                              width: 51,
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 27,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.black54.withOpacity(.3),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    height: (8 / 375.0) * MediaQuery.of(context).size.height),
                Center(
                    child: Text(
                  cDetails.course_name!,
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1B1816)),
                )),
                Center(
                    child: Text(
                  "Author: ${cDetails.admin_name!} \n"
                  "Email: ${cDetails.admin_email}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF979797)),
                )),
                SizedBox(
                    height: (5 / 375.0) * MediaQuery.of(context).size.height),
                ElevatedButton(
                  onPressed: () async {
                    cDetails.courseId = widget.courseId;
                    await cDetails.enrollCourse();
                    Fluttertoast.showToast(
                      msg: cDetails.message_enroll,
                      fontSize: 15,
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 10,
                    );
                    if (cDetails.status_enroll == true) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .05),
                              SvgPicture.asset("images/courseCode0.svg"),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .05),
                              const Text("The Code has been Sent",
                                  style: TextStyle(fontSize: 15)),
                            ],
                          ),
                          content: ElevatedButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder: (context) => Form(
                                  key: _key,
                                  child: AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    title: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .08),
                                        SvgPicture.asset(
                                            "images/courseCode.svg"),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .05),
                                        const Text(
                                            "Enter the Code to Get your course",
                                            style: TextStyle(fontSize: 15)),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .02),
                                        TextFormField(
                                          controller: courseCode,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "مطلوب ادخال رقم";
                                            } else if (!RegExp(r"^[0-9]*$")
                                                .hasMatch(courseCode.text)) {
                                              return "يجب ان يكون ارقام فقط";
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              labelText: "******",
                                              labelStyle: const TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFFD0D0D0)),
                                              fillColor:
                                                  const Color(0xFFF8F8F8),
                                              filled: true),
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.phone,
                                        ),
                                      ],
                                    ),
                                    content: ElevatedButton(
                                      onPressed: () async {
                                        if (_key.currentState!.validate()) {
                                          FocusScope.of(context).unfocus();
                                          exam.courseCode = courseCode.text;
                                          await exam.getExam();

                                          if (exam.status_getExam) {
                                            // exam.courseName =
                                            //     cDetails.course_name!;
                                            Fluttertoast.showToast(
                                              msg: exam.message_getExam,
                                              fontSize: 15,
                                              toastLength: Toast.LENGTH_SHORT,
                                              timeInSecForIosWeb: 10,
                                            );
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => FirstExamScreen()));
                                          } else {
                                            Fluttertoast.showToast(
                                              msg: exam.message_getExam,
                                              fontSize: 15,
                                              toastLength: Toast.LENGTH_SHORT,
                                              timeInSecForIosWeb: 10,
                                            );
                                          }
                                        }
                                      },
                                      child: const Text(
                                        "Submit",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          elevation: 15,
                                          primary: const Color(0xFFFF6600),
                                          minimumSize: Size(0, 50),
                                          // onPrimary: Colors.black,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              "Next",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w700),
                            ),
                            style: ElevatedButton.styleFrom(
                                elevation: 15,
                                primary: const Color(0xFFFF6600),
                                minimumSize: Size(0, 50),
                                // onPrimary: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Start Course",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 15,
                      primary: const Color(0xFFFF6600),
                      minimumSize: const Size(20, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                    height: (10 / 375.0) * MediaQuery.of(context).size.height),
                const Text(
                  "About this Course",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B1816)),
                ),
                SizedBox(
                    height: (3 / 375.0) * MediaQuery.of(context).size.height),
                const AutoSizeText(
                  "Welcome to your UX Design for Beginners Course. In the following tutorials, you'll get a"
                  " thorough introduction to UX design, from its definition, areas and origins through to th"
                  "e skills you need to build a professional portfolio and become a UX designer. ",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF3A3A3A)),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                    height: (10 / 375.0) * MediaQuery.of(context).size.height),
                Container(
                    color: const Color(0xFFFAFAFA),
                    height: MediaQuery.of(context).size.height * .15,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset("images/Level.svg"),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .06),
                              Text(
                                cDetails.course_level!,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF1B1816)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SvgPicture.asset("images/map-pin.svg"),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .06),
                              const Text(
                                "Cairo",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF1B1816)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
                const Text("You may be interested in",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1B1816))),
                SizedBox(height: MediaQuery.of(context).size.height * .01),
                (cDetails.coursDetails.isEmpty)
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: cDetails.coursDetails,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
