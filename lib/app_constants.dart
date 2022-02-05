import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

const cPrimaryColor = Color(0xFF6F35A5);
const cPrimaryLightColor = Color(0xFFF1E6FF);
const cDarkColor = Color(0xFF21202A);
const cDarkColorAccent = Color(0xFF3A3A3A);
const cSilver = Color(0xFFF6F6F6);

var kPageTitleStyle = GoogleFonts.nunito(
  fontSize: 23.0,
  fontWeight: FontWeight.w500,
  color: cDarkColor,
  wordSpacing: 2.5,
);
var kTitleStyle = GoogleFonts.nunito(
  fontSize: 16.0,
  color: cDarkColor,
  fontWeight: FontWeight.w400,
);
var kSubtitleStyle = GoogleFonts.nunito(
  fontSize: 14.0,
  color: cDarkColor,
);

var uSpinner = const SpinKitThreeBounce(
  color: cPrimaryColor,
  size: 50,
);

var uFullSpinner = const SpinKitSpinningLines(
  color: cPrimaryColor,
  size: 75.0,
);

const serverRoot =
    kDebugMode ? "http://10.0.2.2:5000" : "https://apipracticejob.yisus.dev";

String getProfilePicture(String filename, String? type) {
  return "$serverRoot/profile_images/$type/$filename";
}
