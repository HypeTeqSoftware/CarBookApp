import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroWidget extends StatelessWidget {
  const IntroWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height*0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset("assets/icons/app_banner.png",width: 269,height: 104),
          const SizedBox(height: 20),
          Image.asset("assets/images/img_footer.png",fit: BoxFit.cover,width: Get.width,height: Get.height*0.3,)
        ],
      ),
    );
  }
}
