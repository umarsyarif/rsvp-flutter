

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kopiek_resto/presentation/theme/theme_color.dart';

Color kPrimaryColor = const Color(0xFF041E41);
Color kBlackColor = Colors.black;
Color kWhiteColor = const Color(0xffFFFFFF);
Color kGreyColor = const Color(0xff9698A9);
Color kGreenColor = const Color(0xff0EC3AE);
Color kRedColor = const Color(0xffEB70A5);
Color kBackgroundColor = const Color(0xffFAFAFA);
Color kInactiveColor = const Color(0xffDBD7EC);

TextStyle blackTextStyle = GoogleFonts.poppins(
    color: kBlackColor
);
TextStyle whiteTextStyle = GoogleFonts.poppins(
    color: kWhiteColor
);
TextStyle greyTextStyle = GoogleFonts.poppins(
    color: kGreyColor
);
TextStyle greenTextStyle = GoogleFonts.poppins(
    color: kGreenColor
);
TextStyle redTextStyle = GoogleFonts.poppins(
    color: kRedColor
);
TextStyle primaryTextStyle = GoogleFonts.poppins(
    color: AppColor.primary
);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;
FontWeight black = FontWeight.w900;


Widget hSpace(double space) {
  return SizedBox(
    width: space,
  );
}

Widget vSpace(double space) {
  return SizedBox(
    height: space,
  );
}


InputDecoration inputWithBg = InputDecoration(
  filled: true,
  fillColor: const Color(0xfff0f0f0),
  hintText: 'Password',
  contentPadding: const EdgeInsets.only(
      left: 14.0, bottom: 8.0, top: 8.0),
  focusedBorder: OutlineInputBorder(
    borderSide:
    const BorderSide(color: Colors.white, width: 0),
    borderRadius: BorderRadius.circular(10),
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(10),
  ),
);

InputDecoration inputDecoration = InputDecoration(
  filled: true,
  fillColor: const Color(0xfff0f0f0),
  border: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(10),
  ),
  contentPadding: const EdgeInsets.only(
      left: 14.0, bottom: 8.0, top: 8.0),


);

//warna primary
InputDecoration inputDecorationPrimary = InputDecoration(
  filled: true,
  fillColor: const Color(0xff153054),
  contentPadding: const EdgeInsets.only(
      left: 14.0, bottom: 8.0, top: 8.0),
  focusedBorder: OutlineInputBorder(
    borderSide:BorderSide.none,
    borderRadius: BorderRadius.circular(10),
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide:BorderSide.none,
    borderRadius: BorderRadius.circular(10),
  ),
);