import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Authentication/Login/Login_View.dart';
import 'Profile_Model.dart';

class ProfileDetailsScreen extends StatefulWidget {
  ProfileDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  late Future _future;

  Future<void> prepareData() async {
    var profile = Provider.of<Profile>(context, listen: false);
    (profile.student_name.isEmpty) ? await profile.getProfileDetails() : null;
  }

  @override
  void initState() {
    _future = prepareData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var profile = Provider.of<Profile>(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFFFCFCFC),
            elevation: 0,
            title: const Text("My Profile",
                style: TextStyle(
                  color: Color(0xFFFF6600),
                  fontSize: 30,
                )),
            actions: [
              InkWell(
                  onTap: () async {
                    profile.logOut();
                    if (profile.status) {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.remove("access_token");
                      await prefs.remove("refresh_token");

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => LoginScreen()),
                          ModalRoute.withName('/'));
                    }
                  },
                  child: SvgPicture.asset("images/Logout.svg")),
              SizedBox(width: MediaQuery.of(context).size.width * .05),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                          radius: MediaQuery.of(context).size.height * 0.08,
                          backgroundImage: const AssetImage("images/me.jpg"),
                          child: const FractionallySizedBox(
                            heightFactor: 0.9,
                          )),
                      Positioned(
                          right: 0,
                          bottom: 5,
                          child: CircleAvatar(
                            radius: 17,
                            backgroundColor: Colors.red,
                            child: IconButton(
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 21,
                              ),
                              onPressed: () {},
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .05),
                AutoSizeText(
                  "${profile.student_name}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1B1816)),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .02),
                AutoSizeText(
                  "${profile.email}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF1B1816)),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .06),
                const Text(
                  "My Achievement",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF3A3A3A)),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .15),
                Center(
                  child: const Text(
                    "No Achievement",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepOrange),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
