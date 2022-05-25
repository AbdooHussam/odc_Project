import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:odc/Screens/Home/Courses/CourseDetails/CourseDetails_Model.dart';
import 'package:odc/Screens/Home/Courses/CourseDetails/CourseDetails_View.dart';
import 'package:provider/provider.dart';

class CourseDetailsCard extends StatelessWidget {
  CourseDetailsCard({
    Key? key,
    this.course_name = "",
    this.category_name = "",
    this.id = "",
    this.catId = "",
    this.admin_name = "",
  }) : super(key: key);

  final String course_name;
  final String category_name;
  final String id;
  final String catId;
  final String admin_name;

  @override
  Widget build(BuildContext context) {
    var cDetails = Provider.of<CourseDetailsModel>(context);
    return InkWell(
      onTap: () async {
        cDetails.courseId = id;
        await cDetails.getCoursesDetails();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => CourseDetailsScreen(courseId: id,)));
      },
      child: Container(
        height: MediaQuery.of(context).size.height * .13,
        margin: const EdgeInsets.only(right: 15, bottom: 5),
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
            color: Color(0xFFF8F8F8), borderRadius: BorderRadius.circular(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                "images/mobile2.png",
                fit: BoxFit.cover,
                height: (47 / 375.0) * MediaQuery.of(context).size.height,
                width: (75 / 375.0) * MediaQuery.of(context).size.width,
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * .025),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .02),
              child: Text(
                course_name,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
