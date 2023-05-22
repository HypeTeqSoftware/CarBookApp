import 'package:carbook/controller/auth_controller.dart';
import 'package:carbook/screens/login/widgets/intro_widget.dart';
import 'package:carbook/screens/otp/widgets/otp_widget.dart';
import 'package:carbook/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OTPScreen extends StatefulWidget {
  static String routeName = "/OTPScreen";

  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {

  String phone_number = "";

  AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {

    setState(() {
      phone_number = ModalRoute.of(context)!.settings.arguments as String;
    });

    authController.phoneAuth(phone_number);

    return Scaffold(
      backgroundColor: AppColors.greenColor,
      body: SizedBox(
          width: Get.width,
          height: Get.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(children: [
                  const IntroWidget(),
                  Positioned(
                    top: 45,
                    left: 25,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: const Icon(
                          Icons.arrow_back,
                          color: AppColors.greenColor,
                          size: 20,
                        ),
                      ),
                    ),
                  )
                ]),
                Container(
                    width: Get.width,
                    height: Get.height - Get.height * 0.6,
                    decoration: const BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                child: const OTPWidgets())
              ],
            ),
          )),
    );
  }


}
