import 'package:carbook/common_widgets/text_widget.dart';
import 'package:carbook/utils/app_colors.dart';
import 'package:carbook/utils/app_constants.dart';
import 'package:carbook/utils/show_snack_bar.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget CountryMobileWidget(
    CountryCode countryCode, Function onCountryChange, Function onSubmit) {
  TextEditingController txtNumber = TextEditingController();

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          width: double.infinity,
          height: 55,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 3,
                    blurRadius: 3)
              ],
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () => onCountryChange(),
                    child: Container(
                      child: Row(
                        children: [
                          const SizedBox(width: 5),

                          Expanded(
                            child: Container(
                              child: countryCode.flagImage,
                            ),
                          ),

                          textWidget(text: countryCode.dialCode),

                          // const SizedBox(width: 10,),

                          const Icon(Icons.keyboard_arrow_down_rounded)
                        ],
                      ),
                    ),
                  )),
              Container(
                width: 1,
                height: 55,
                color: Colors.black.withOpacity(0.2),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: txtNumber,
                    onSubmitted: (String? input) => onSubmit(input),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        hintStyle: GoogleFonts.poppins(
                            fontSize: 12, fontWeight: FontWeight.normal),
                        hintText: AppConstants.enterMobileNumber,
                        border: InputBorder.none),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () {
                if (txtNumber.text.isEmpty) {
                  ShowSnackBar.showSnackBar(text: "Please enter your mobile number");
                }
                else {
                  onSubmit(txtNumber.text);
                }
              },
              child: const Text("Continue")),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: GoogleFonts.poppins(color: Colors.black, fontSize: 12),
                children: [
                  const TextSpan(
                    text: "${AppConstants.byCreating} ",
                  ),
                  TextSpan(
                      text: "${AppConstants.termsOfService} ",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                  const TextSpan(
                    text: "and ",
                  ),
                  TextSpan(
                      text: "${AppConstants.privacyPolicy} ",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                ]),
          ),
        )
      ],
    ),
  );
}
