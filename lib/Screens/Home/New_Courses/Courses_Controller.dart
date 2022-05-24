import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'CourseDetails/CourseDetails_Model.dart';
import 'CourseDetails/CourseDetails_View.dart';

class AllCoursesCard extends StatelessWidget {
  AllCoursesCard({
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
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
      child: InkWell(
        onTap: () async {
          cDetails.catId = catId;
          await cDetails.getCoursesDetails();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CourseDetailsScreen()));
        },
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "images/mobile2.png",
                      fit: BoxFit.cover,
                      height: (47 / 375.0) * MediaQuery.of(context).size.height,
                      width: (75 / 375.0) * MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * .05),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course_name,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          admin_name,
                          style: const TextStyle(
                              color: Color(0xFF979797), fontSize: 12),
                        ),
                        const SizedBox(width: 7),
                        const Icon(
                          Icons.circle,
                          size: 10,
                          color: Color(0xFFB7B7B7),
                        ),
                        const AutoSizeText(
                          "15 Hours",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: const Color(0xFF979797)),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Divider(color: Colors.grey, thickness: 1),
          ],
        ),
      ),
    );
  }
}
