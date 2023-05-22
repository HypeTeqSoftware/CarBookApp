import 'package:carbook/screens/login/widgets/country_mobile_widget.dart';
import 'package:carbook/screens/login/widgets/intro_widget.dart';
import 'package:carbook/screens/otp/otp_screen.dart';
import 'package:carbook/utils/app_colors.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "/LoginScreen";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final countryPicker = const FlCountryCodePicker();

  CountryCode countryCode = CountryCode(name: 'India', code: "IN", dialCode: "+91");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenColor,
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const IntroWidget(),
              Container(
                width: Get.width,
                height: Get.height-Get.height*0.6,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFFFFF),borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    const Text("Sign in now"),
                    CountryMobileWidget(countryCode,()async{
                      final code = await countryPicker.showPicker(context: context);
                      if (code != null)  countryCode = code;
                      setState(() {

                      });
                    },onSubmit),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  onSubmit(String? input){
    Navigator.pushNamed(context, OTPScreen.routeName,arguments: countryCode.dialCode+input!);
  }
}
