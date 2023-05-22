import 'package:carbook/common_widgets/text_widget.dart';
import 'package:carbook/screens/otp/widgets/pinput_widget.dart';
import 'package:carbook/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class OTPWidgets extends StatelessWidget {
  const OTPWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
          ),
          textWidget(text: AppConstants.phoneVerification),
          textWidget(
              text: AppConstants.enterOtp,
              fontSize: 22,
              fontWeight: FontWeight.bold),
          const SizedBox(
            height: 20,
          ),
          Container(
              width: Get.width,
              height: 50,
              child: RoundedWithShadow()),
          const SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}
