// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ENEB_HUB/constant/Styles/Colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obsecureText;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obsecureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: MediaQuery.of(context).size.width.w,
      decoration: BoxDecoration(
        color: white,
        border: Border.all(color: black.withOpacity(0.7), width: 2.r),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.text,
            style: GoogleFonts.electrolize(
                fontWeight: FontWeight.bold, color: black),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.electrolize(
                  fontWeight: FontWeight.bold, color: grey.shade500),
              border: InputBorder.none,
            ),
            obscureText: obsecureText,
          ),
        ),
      ),
    );
  }
}
