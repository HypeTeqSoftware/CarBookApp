import 'package:carbook/common_widgets/green_widget_without_logo.dart';
import 'package:flutter/material.dart';

class VerificaitonPendingScreen extends StatefulWidget {
  static String routeName = "/VerificaitonPendingScreen";

  const VerificaitonPendingScreen({Key? key}) : super(key: key);

  @override
  State<VerificaitonPendingScreen> createState() =>
      _VerificaitonPendingScreenState();
}

class _VerificaitonPendingScreenState extends State<VerificaitonPendingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GreenWidgetWithoutLogo(
              title: 'Verification!', subtitle: 'process status'),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Verification Pending',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Your document is still pending for verification. Once it’s all verified you start getting rides. please sit tight',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff7D7D7D)),
                textAlign: TextAlign.center,
              ),
            ],
          )),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
