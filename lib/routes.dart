
import 'package:carbook/screens/driver/car_registration/car_registration_template.dart';
import 'package:carbook/screens/driver/car_registration/verification_pending_screen.dart';
import 'package:carbook/screens/driver/driver_user_profile/drive_profile_setup.dart';
import 'package:carbook/screens/home/home_screen.dart';
import 'package:carbook/screens/login/login_screen.dart';
import 'package:carbook/screens/otp/otp_screen.dart';
import 'package:carbook/screens/payment/add_payment_card.dart';
import 'package:carbook/screens/payment/payment_history.dart';
import 'package:carbook/screens/profile_settings/profile_settings_screen.dart';
import 'package:carbook/screens/user_profile/user_profile.dart';
import 'package:carbook/screens/user_selection/user_selection_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => const LoginScreen(),
  OTPScreen.routeName: (context) => const OTPScreen(),
  ProfileSettingScreen.routeName: (context) => const ProfileSettingScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  MyProfile.routeName: (context) => const MyProfile(),
  PaymentHistoryScreen.routeName: (context) => const PaymentHistoryScreen(),
  AddPaymentCardScreen.routeName: (context) => const AddPaymentCardScreen(),
  UserSelectionScreen.routeName: (context) => const UserSelectionScreen(),
  DriverProfileSetup.routeName: (context) => const DriverProfileSetup(),
  CarRegistrationTemplate.routeName: (context) => const CarRegistrationTemplate(),
  VerificaitonPendingScreen.routeName: (context) => const VerificaitonPendingScreen(),
};