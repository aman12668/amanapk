import 'dart:io';

import 'package:ENEB_HUB/Widgets/CustomButton.dart';
import 'package:ENEB_HUB/constant/Styles/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:page_transition/page_transition.dart';

class CustomWillPopScope extends StatelessWidget {
  final child;
  const CustomWillPopScope({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: child,
        onWillPop: () async {
          final value = await showModalBottomSheet(
            isDismissible: true,
            backgroundColor: white,
            barrierColor: Colors.black.withOpacity(0.5),
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.r),
                topRight: Radius.circular(15.r),
              ),
            ),
            context: context,
            builder: (context) => Stack(
                alignment: AlignmentDirectional.topCenter,
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -15,
                    child: Container(
                      height: 2.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                  SingleChildScrollView(
                      child: Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 40.0, horizontal: 20.w),
                        child: Column(
                          children: [
                            Text(
                              "EXIT THE ENEB HUB",
                              style: GoogleFonts.electrolize(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                  color: black),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              "Are you sure want to exit the app and loss your progress ?",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.electrolize(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10.sp,
                                  color: black),
                            ),
                            SizedBox(
                              height: 14.h,
                            ),
                            CustomButton(
                              onTap: () {
                                exit(0);
                              },
                              padding: 10.h,
                              height: 40.h,
                              width: MediaQuery.of(context).size.width.w,
                              color: grey.shade200,
                              child: Center(
                                child: Text(
                                  "EXIT APP",
                                  style: GoogleFonts.electrolize(
                                      fontWeight: FontWeight.bold,
                                      color: black,
                                      fontSize: 11.sp),
                                ),
                              ),
                            ),
                          ],
                        )),
                  )),
                ]),
          );
          if (value != null) {
            return Future.value(value);
          } else {
            return Future.value(false);
          }
          ;
        });
  }
}
