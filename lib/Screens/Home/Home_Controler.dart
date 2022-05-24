import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Categories/Categories_Model.dart';
import 'Categories/allCategoriesDetails/allCatDetails_View.dart';
import 'New_Courses/CourseDetails/CourseDetails_Model.dart';
import 'New_Courses/CourseDetails/CourseDetails_View.dart';

class CategoriesCard extends StatelessWidget {
  CategoriesCard({
    this.name = "slalah",
    required this.image,
    this.catId = "",
  });

  final String name;
  final String catId;

  final String image;

  @override
  Widget build(BuildContext context) {
    var getCat = Provider.of<CategoriesModel>(context);
    return InkWell(
      onTap: ()async {
        getCat.catId = catId;
         await getCat.getCategoriesDetails();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AllCatDetails()));

      },
      child: Padding(
        padding: EdgeInsets.only(
            right: (10 / 375.0) * MediaQuery.of(context).size.width),
        child: SizedBox(
          width: (75 / 350) * MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: (70 / 350) * MediaQuery.of(context).size.width,
                height: (70 / 700) * MediaQuery.of(context).size.height,
                child: Card(
                  elevation: 7,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Image.network(
                      image == null
                          ? "https://cdn-icons-png.flaticon.com/512/4974/4974492.png"
                          : image,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: (7 / 700) * MediaQuery.of(context).size.height,
              ),
              AutoSizeText(name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}

class CoursesCards extends StatelessWidget {
  CoursesCards(
      {this.course_name = "",
      this.category_name = "",
      this.id = "",
      this.catId = "",
      this.admin_name = ""});

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
        cDetails.id = id;
        await cDetails.getCoursesDetails();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const CourseDetailsScreen()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.52,
        margin: const EdgeInsets.only(right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.47,
              height: (49 / 375.0) * MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      image: AssetImage("images/Photo.png"), fit: BoxFit.fill)),
            ),
            SizedBox(height: (5 / 375.0) * MediaQuery.of(context).size.height),
            AutoSizeText(category_name,
                maxLines: 1,
                style: const TextStyle(fontSize: 9, color: Color(0xFFFF6600)),
                textAlign: TextAlign.start),
            SizedBox(height: (2 / 375.0) * MediaQuery.of(context).size.height),
            AutoSizeText(course_name,
                maxLines: 2,
                style: const TextStyle(
                    fontSize: 17,
                    color: Color(0xFF1B1816),
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.start),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AutoSizeText(
                  admin_name,
                  style:
                      const TextStyle(color: Color(0xFF979797), fontSize: 12),
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
      ),
    );
  }
}
