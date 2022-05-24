import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'CourseDetails_Model.dart';

class CourseDetailsScreen extends StatefulWidget {
  const CourseDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  late Future _future;

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
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Container(
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
                onPressed: () {},
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
                                width: MediaQuery.of(context).size.width * .06),
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
                                width: MediaQuery.of(context).size.width * .06),
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
    );
  }
}
