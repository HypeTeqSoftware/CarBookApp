import 'dart:developer';
import 'dart:io';
import 'package:carbook/models/user_model.dart';
import 'package:carbook/screens/driver/car_registration/verification_pending_screen.dart';
import 'package:carbook/screens/home/home_screen.dart';
import 'package:carbook/screens/profile_settings/profile_settings_screen.dart';
import 'package:carbook/utils/global_context.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:path/path.dart' as Path;
import 'package:geocoding/geocoding.dart' as geoCoding;
import '../screens/driver/driver_user_profile/drive_profile_setup.dart';
import '../utils/app_constants.dart';

class AuthController extends GetxController {
  String userUid = '';
  var verId = '';
  int? resendTokenId;
  bool phoneAuthCheck = false;
  dynamic credentials;

  var myUser = UserModel().obs;

  var isProfileUploading = false.obs;

  bool isLoginAsDriver = false;

  phoneAuth(String phone) async {
    try {
      credentials = null;
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          log('Completed');
          credentials = credential;
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        forceResendingToken: resendTokenId,
        verificationFailed: (FirebaseAuthException e) {
          log('Failed');
          if (e.code == 'invalid-phone-number') {
            debugPrint('The provided phone number is not valid.');
          }
        },
        codeSent: (String verificationId, int? resendToken) async {
          log('Code sent');
          verId = verificationId;
          resendTokenId = resendToken;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      log("Error occured $e");
    }
  }

  verifyOtp(BuildContext context, String otpNumber) async {
    log("Called");
    PhoneAuthCredential credential =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: otpNumber);

    log("LogedIn");

    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      decideRoute(context);
    }).catchError((e) {
      print("Error while sign In $e");
    });
  }

  var isDecided = false;

  decideRoute(BuildContext context) {
    if (isDecided) {
      return;
    }
    isDecided = true;
    print("called");

    ///step 1- Check user login?
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      /// step 2- Check whether user profile exists?
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .then((value) {
        if (isLoginAsDriver) {
          if (value.exists) {
            print("Driver HOme Screen");
          } else {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const DriverProfileSetup()),
                ModalRoute.withName(DriverProfileSetup.routeName));
          }
        } else {
          if (value.exists) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomeScreen()),
                ModalRoute.withName(HomeScreen.routeName));
          } else {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const ProfileSettingScreen()),
                ModalRoute.withName(ProfileSettingScreen.routeName));
          }
        }
      }).catchError((e) {
        print("Error while decideRoute is $e");
      });
    }
  }

  Future<bool> checkIfLoggedIn() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return true;
    }
    return false;
  }

  storeUserInfo(
    File? selectedImage,
    String name,
    String home,
    String business,
    String shop, {
    String url = '',
  }) async {
    String urlNew = url;
    if (selectedImage != null) {
      urlNew = await uploadImage(selectedImage);
    }
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('users').doc(uid).set({
      'image': urlNew,
      'name': name,
      'home_address': home,
      'business_address': business,
      'shopping_address': shop,
    }, SetOptions(merge: true)).then((value) {
      isProfileUploading(false);
      NavigationService.navigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          ModalRoute.withName(HomeScreen.routeName));
    });
  }

  uploadImage(File image) async {
    String imageUrl = '';
    String fileName = Path.basename(image.path);
    var reference = FirebaseStorage.instance
        .ref()
        .child('users/$fileName'); // Modify this path/string as your need
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    await taskSnapshot.ref.getDownloadURL().then(
      (value) {
        imageUrl = value;
        print("Download URL: $value");
      },
    );

    return imageUrl;
  }

  getUserInfo() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .listen((event) {
      myUser.value = UserModel.fromJson(event.data()!);
    });
  }

  Future<Prediction?> showGoogleAutoComplete(BuildContext context) async {
    Prediction? p = await PlacesAutocomplete.show(
      offset: 0,
      radius: 1000,
      strictbounds: false,
      region: "IN",
      language: "en",
      context: context,
      mode: Mode.overlay,
      apiKey: AppConstants.googleApiKey,
      components: [Component(Component.country, "IN")],
      types: [],
      hint: "Search City",
      onError: (value) {
        print("place error->$value");
      },
    );

    return p;
  }

  Future<LatLng> buildLatLngFromAddress(String place) async {
    List<geoCoding.Location> locations =
        await geoCoding.locationFromAddress(place);
    return LatLng(locations.first.latitude, locations.first.longitude);
  }

  RxList userCards = [].obs;

  getUserCards() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('cards')
        .snapshots()
        .listen((event) {
      userCards.value = event.docs;
    });
  }

  storeUserCard(String number, String expiry, String cvv, String name) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('cards')
        .add({'name': name, 'number': number, 'cvv': cvv, 'expiry': expiry});

    return true;
  }

  storeDriverProfile(
    File? selectedImage,
    String name,
    String email, {
    String url = '',
  }) async {
    String url_new = url;
    if (selectedImage != null) {
      url_new = await uploadImage(selectedImage);
    }
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('users').doc(uid).set(
        {'image': url_new, 'name': name, 'email': email, 'isDriver': true},
        SetOptions(merge: true)).then((value) {
      isProfileUploading(false);
      NavigationService.navigatorKey.currentState?.pushNamed(VerificaitonPendingScreen.routeName);
    });
  }

  Future<bool> uploadCarEntry(Map<String,dynamic> carData)async{
    bool isUploaded = false;
    String uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance.collection('users').doc(uid).set(carData,SetOptions(merge: true));

    isUploaded = true;

    return isUploaded;
  }
}
