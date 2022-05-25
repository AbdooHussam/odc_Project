import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:odc/size_config.dart';
import 'package:provider/provider.dart';
import '../ForgetPassword_Model.dart';
import 'components/otp_form.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({this.phone});

  // static String routeName = "/otp";

  String? phone = "0";

  @override
  Widget build(BuildContext context) {
    var forget = Provider.of<ForgetPassModel>(context);
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "Verify Your Email",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black),
        ),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SvgPicture.asset("images/forgetPass2.svg",
                    height: MediaQuery.of(context).size.height * .2),
                 AutoSizeText(
                  "\nplease enter the 4-digit code sent to\n",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1B1816)),
                ),
                 AutoSizeText(
                  "${forget.email}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFFF6600)),
                ),
                OtpForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code will expired in ",
            style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0.0),
          duration: Duration(seconds: 30),
          builder: (_, dynamic value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
