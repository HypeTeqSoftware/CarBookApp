import 'dart:io';

import 'package:carbook/common_widgets/green_widget_without_logo.dart';
import 'package:carbook/screens/driver/car_registration/pages/document_uploaded_page.dart';
import 'package:carbook/screens/driver/car_registration/pages/location_page.dart';
import 'package:carbook/screens/driver/car_registration/pages/upload_document_page.dart';
import 'package:carbook/screens/driver/car_registration/pages/vehical_color_page.dart';
import 'package:carbook/screens/driver/car_registration/pages/vehical_make.dart';
import 'package:carbook/screens/driver/car_registration/pages/vehical_model_page.dart';
import 'package:carbook/screens/driver/car_registration/pages/vehical_model_year_page.dart';
import 'package:carbook/screens/driver/car_registration/pages/vehical_number_page.dart';
import 'package:carbook/screens/driver/car_registration/pages/vehical_type_page.dart';
import 'package:carbook/screens/driver/car_registration/verification_pending_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../controller/auth_controller.dart';
import '../../../utils/app_colors.dart';

class CarRegistrationTemplate extends StatefulWidget {
  static String routeName = "/CarRegistrationTemplate";

  const CarRegistrationTemplate({Key? key}) : super(key: key);

  @override
  State<CarRegistrationTemplate> createState() =>
      _CarRegistrationTemplateState();
}

class _CarRegistrationTemplateState extends State<CarRegistrationTemplate> {
  String selectedLocation = '';
  String selectedVehicalType = '';
  String selectedVehicalMake = '';
  String selectedVehicalModel = '';
  String selectModelYear = '';
  PageController pageController = PageController();
  TextEditingController vehicalNumberController = TextEditingController();
  String vehicalColor = '';
  File? document;

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GreenWidgetWithoutLogo(
              title: 'Car Registration',
              subtitle: 'Complete the process detail'),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: PageView(
                onPageChanged: (int page) {
                  currentPage = page;
                },
                controller: pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  LocationPage(
                    selectedLocation: selectedLocation,
                    onSelect: (String location) {
                      setState(() {
                        selectedLocation = location;
                      });
                    },
                  ),
                  VehicalTypePage(
                    selectedVehical: selectedVehicalType,
                    onSelect: (String vehicalType) {
                      setState(() {
                        selectedVehicalType = vehicalType;
                      });
                    },
                  ),
                  VehicalMakePage(
                    selectedVehical: selectedVehicalMake,
                    onSelect: (String vehicalMake) {
                      setState(() {
                        selectedVehicalMake = vehicalMake;
                      });
                    },
                  ),
                  VehicalModelPage(
                    selectedModel: selectedVehicalModel,
                    onSelect: (String vehicalModel) {
                      setState(() {
                        selectedVehicalModel = vehicalModel;
                      });
                    },
                  ),
                  VehicalModelYearPage(
                    onSelect: (int year) {
                      setState(() {
                        selectModelYear = year.toString();
                      });
                    },
                  ),
                  VehicalNumberPage(
                    controller: vehicalNumberController,
                  ),
                  VehicalColorPage(
                    onColorSelected: (String selectedColor) {
                      vehicalColor = selectedColor;
                    },
                  ),
                  UploadDocumentPage(
                    onImageSelected: (File image) {
                      document = image;
                    },
                  ),
                  DocumentUploadedPage()
                ],
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(() => isUploading.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : FloatingActionButton(
                        onPressed: () {
                          if (currentPage < 8) {
                            pageController.animateToPage(currentPage + 1,
                                duration: const Duration(seconds: 1),
                                curve: Curves.easeIn);
                          } else {
                            uploadDriverCarEntry(context);
                          }
                        },
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        backgroundColor: AppColors.greenColor,
                      )),
              )),
        ],
      ),
    );
  }

  var isUploading = false.obs;

  void uploadDriverCarEntry(BuildContext context) async {
    isUploading(true);
    String imageUrl = await Get.find<AuthController>().uploadImage(document!);

    Map<String, dynamic> carData = {
      'country': selectedLocation,
      'vehicle_type': selectedVehicalType,
      'vehicle_make': selectedVehicalMake,
      'vehicle_model': selectedVehicalModel,
      'vehicle_year': selectModelYear,
      'vehicle_number': vehicalNumberController.text.trim(),
      'vehicle_color': vehicalColor,
      'document': imageUrl
    };

    await Get.find<AuthController>().uploadCarEntry(carData);
    isUploading(false);
    Navigator.pushNamed(context, VerificaitonPendingScreen.routeName);
  }
}
