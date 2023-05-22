import 'package:carbook/screens/login/login_screen.dart';
import 'package:carbook/screens/user_selection/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/auth_controller.dart';
import '../../utils/app_colors.dart';
import '../login/widgets/intro_widget.dart';

class UserSelectionScreen extends StatelessWidget {
  static String routeName = "/UserSelectionScreen";

  const UserSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AuthController authController = Get.find<AuthController>();

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
                height: Get.height - Get.height * 0.6,
                decoration: const BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buttonWidget(
                        'assets/icons/driver_icon.png', 'Login As Driver', () {
                      authController.isLoginAsDriver = true;
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    }, Get.width * 0.8),
                    const SizedBox(
                      height: 20,
                    ),
                    buttonWidget(
                        'assets/icons/customer_icon.png', 'Login As User', () {
                      authController.isLoginAsDriver = false;
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    }, Get.width * 0.8),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
