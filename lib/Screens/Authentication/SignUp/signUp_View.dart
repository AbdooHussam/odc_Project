import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:odc/Screens/Home/Home/NavBar_Screen.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../Provider/userInformation.dart';
import '../Login/Login_View.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool securePass = true;
  String name = "", email = "", pass = "", phone = "", address = "";
  bool showSpinner = false, _checked = false;
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final iskeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    double h = MediaQuery.of(context).size.height * .001;
    var api = Provider.of<UserInformation>(context);
    return SafeArea(
      child: Scaffold(
          body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Form(
          key: _key,
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (!iskeyboard)
                  Align(
                      child: Image.asset("images/topRight.png", height: 60),
                      alignment: Alignment.topRight),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height * 0.01,
                      // ),
                      SizedBox(
                        height: 30,
                        child: Row(
                          children: const [
                            AutoSizeText("Hello,",
                                style: TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.w700)),
                            AutoSizeText("Friend!",
                                style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFFFF6600))),
                          ],
                        ),
                      ),
                      const AutoSizeText("Sign Up",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF3A3A3A))),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025,
                      ),
                      TextFormField(
                        onChanged: (val) {
                          name = val;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Feild is Required";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: h),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            prefixIcon: const Icon(
                              Icons.person,
                              size: 25,
                              color: Color(0xFFD0D0D0),
                            ),
                            labelText: "Full Name",
                            labelStyle: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFD0D0D0)),
                            hintText: "Enter your Name",
                            hintStyle: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFD0D0D0)),
                            fillColor: const Color(0xFFF8F8F8),
                            filled: true),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      TextFormField(
                        onChanged: (val) {
                          email = val;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Feild is Required";
                          } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(email)) {
                            return "Email not Valid";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: h),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            prefixIcon: const Icon(
                              Icons.email,
                              size: 25,
                              color: Color(0xFFD0D0D0),
                            ),
                            labelText: "Email",
                            labelStyle: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFD0D0D0)),
                            hintText: "*****@***.com",
                            hintStyle: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFD0D0D0)),
                            fillColor: const Color(0xFFF8F8F8),
                            filled: true),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      TextFormField(
                        onChanged: (val) {
                          pass = val;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Feild is Required";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: h),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            prefixIcon: const Icon(
                              Icons.lock,
                              size: 25,
                              color: Color(0xFFD0D0D0),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  securePass = !securePass;
                                });
                              },
                              icon: securePass
                                  ? const Icon(
                                      Icons.remove_red_eye_outlined,
                                      size: 20,
                                      color: Color(0xFFD0D0D0),
                                    )
                                  : const FaIcon(
                                      FontAwesomeIcons.eyeSlash,
                                      size: 15,
                                      color: Color(0xFFD0D0D0),
                                    ),
                            ),
                            labelText: "Password",
                            labelStyle: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFD0D0D0)),
                            hintText: "Enter your Password",
                            hintStyle: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFD0D0D0)),
                            fillColor: const Color(0xFFF8F8F8),
                            filled: true),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: securePass,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      TextFormField(
                        onChanged: (val) {
                          phone = val;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Feild is Required";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: h),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            prefixIcon: const Icon(
                              Icons.phone,
                              size: 25,
                              color: Color(0xFFD0D0D0),
                            ),
                            labelText: "Phone number",
                            labelStyle: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFD0D0D0)),
                            hintText: "Enter your Phone",
                            hintStyle: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFD0D0D0)),
                            fillColor: const Color(0xFFF8F8F8),
                            filled: true),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      TextFormField(
                        onChanged: (val) {
                          address = val;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Feild is Required";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: h),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            prefixIcon: const Icon(
                              Icons.location_on_outlined,
                              size: 25,
                              color: Color(0xFFD0D0D0),
                            ),
                            labelText: "Address",
                            labelStyle: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFD0D0D0)),
                            hintText: "Enter your Address",
                            hintStyle: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFD0D0D0)),
                            fillColor: const Color(0xFFF8F8F8),
                            filled: true),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                        keyboardType: TextInputType.streetAddress,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: _checked,
                              onChanged: (bool? newVal) {
                                setState(() {
                                  _checked = newVal!;
                                });
                              }),
                          const Text("Do you agree to our",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w400)),
                          TextButton(
                              child: const Text(
                                "Privacy Policy",
                                style: TextStyle(
                                    color: Color(0xFFFF6600),
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w400),
                              ),
                              onPressed: () {}),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_key.currentState!.validate()) {
                              if (_checked != true) {
                                Fluttertoast.showToast(
                                  msg:
                                      "Please agree to the Privacy Policy first",
                                  fontSize: 15,
                                  toastLength: Toast.LENGTH_SHORT,
                                  timeInSecForIosWeb: 10,
                                );
                              }
                              if (_checked == true) {
                                setState(() {
                                  showSpinner = true;
                                });
                                api.email = email;
                                api.fullName = name;
                                api.pass = pass;
                                api.phone = phone;
                                api.address = address;
                                await api.register();

                                Fluttertoast.showToast(
                                  msg: api.message_reg,
                                  fontSize: 15,
                                  toastLength: Toast.LENGTH_SHORT,
                                  timeInSecForIosWeb: 10,
                                );
                                showSpinner = false;

                                if (api.status_reg == true &&
                                    _checked == true) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Nav_Home()));
                                }
                                showSpinner = false;
                              }
                            }
                          },
                          child: const Text(
                            "SIGN UP",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                          style: ElevatedButton.styleFrom(
                              elevation: 15,
                              primary: const Color(0xFFFF6600),
                              // onPrimary: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
                              },
                              child: const Text(
                                "Log in",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFFFF6600),
                                    fontWeight: FontWeight.w900),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .005),
                Align(
                    child: Image.asset("images/bottomLeft.png", height: 60),
                    alignment: Alignment.bottomLeft),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
