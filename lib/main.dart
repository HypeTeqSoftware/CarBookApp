import 'package:carbook/controller/auth_controller.dart';
import 'package:carbook/firebase_options.dart';
import 'package:carbook/routes.dart';
import 'package:carbook/screens/home/home_screen.dart';
import 'package:carbook/screens/login/login_screen.dart';
import 'package:carbook/screens/payment/add_payment_card.dart';
import 'package:carbook/screens/profile_settings/profile_settings_screen.dart';
import 'package:carbook/screens/user_selection/user_selection_screen.dart';
import 'package:carbook/utils/app_colors.dart';
import 'package:carbook/utils/global_context.dart';
import 'package:carbook/utils/show_snack_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    AuthController authController = Get.put(AuthController());

    return MaterialApp(
        title: 'Car Book',
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.navigatorKey,
        scaffoldMessengerKey: ShowSnackBar.messengerKey,
        theme: ThemeData(
          primarySwatch: buildMaterialColor(AppColors.greenColor),
          textTheme: GoogleFonts.poppinsTextTheme(textTheme),
        ),
        routes: routes,
        home: FutureBuilder(
          future: authController.checkIfLoggedIn(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Container(
                  color: Colors.white,
                  child: const Center(child: CircularProgressIndicator()),
                );
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasData) {
                  return (snapshot.data == true)
                      ? const HomeScreen()
                      : const LoginScreen();
                }
                return Container(
                  color: Colors.white,
                  child: const Center(child: CircularProgressIndicator()),
                ); // error view
              default:
                return Container(
                  color: Colors.white,
                  child: const Center(child: CircularProgressIndicator()),
                ); // error view
            }
          },
        ));
  }

  MaterialColor buildMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
}
