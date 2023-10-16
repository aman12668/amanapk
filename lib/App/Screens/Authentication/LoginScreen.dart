import 'dart:developer';

import 'package:ENEB_HUB/App/Screens/Authentication/SignUpScreen.dart';
import 'package:ENEB_HUB/Widgets/CustomButton.dart';
import 'package:ENEB_HUB/Widgets/CustomExit.dart';
import 'package:ENEB_HUB/Widgets/LoginTextField.dart';
import 'package:ENEB_HUB/Widgets/customWillPopScope.dart';
import 'package:ENEB_HUB/constant/Animations/WidgetFadeAnimation.dart';
import 'package:ENEB_HUB/constant/Styles/Colors.dart';
import 'package:ENEB_HUB/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';

import 'package:page_transition/page_transition.dart';

class LoginScreen extends StatefulWidget {
  final Function()? onTap;

  const LoginScreen({
    super.key,
    this.onTap,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  // late Animation _animation;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  //animation--end!!

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1000,
      ),
    );

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width.w;

    return CustomWillPopScope(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: SizedBox(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 14.h,
                          ),
                          FadeIn(
                              animation: Tween(begin: 0.0, end: 1.0).animate(
                                CurvedAnimation(
                                  parent: _animationController,
                                  curve: const Interval((1 / 7) * 0, 1.0,
                                      curve: Curves.fastOutSlowIn),
                                ),
                              ),
                              controller: _animationController,
                              child: CustomExit()),
                          SizedBox(
                            height: 45.h,
                          ),
                          Center(
                            child: FadeIn(
                              animation: Tween(begin: 0.0, end: 1.0).animate(
                                CurvedAnimation(
                                  parent: _animationController,
                                  curve: const Interval((1 / 7) * 0, 1.0,
                                      curve: Curves.fastOutSlowIn),
                                ),
                              ),
                              controller: _animationController,
                              child: Text(
                                "Welcome Back",
                                style: GoogleFonts.lato(
                                    fontWeight: FontWeight.bold,
                                    color: black,
                                    fontSize: 28.sp,
                                    letterSpacing: 1.r),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Center(
                            child: FadeIn(
                              animation: Tween(begin: 0.0, end: 1.0).animate(
                                CurvedAnimation(
                                  parent: _animationController,
                                  curve: const Interval((1 / 7) * 0, 1.0,
                                      curve: Curves.fastOutSlowIn),
                                ),
                              ),
                              controller: _animationController,
                              child: Text(
                                "You've been missed a lot ! Select your specific topic and enlarge your knowledge deeply",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold,
                                  color: black.withOpacity(0.7),
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 45.h,
                          ),
                          FadeIn(
                              animation: Tween(begin: 0.0, end: 1.0).animate(
                                CurvedAnimation(
                                  parent: _animationController,
                                  curve: const Interval((1 / 7) * 0, 1.0,
                                      curve: Curves.fastOutSlowIn),
                                ),
                              ),
                              controller: _animationController,
                              child: const LoginForm()),
                          SizedBox(
                            height: 30.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                  height: 40.h,
                  width: mq?.width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: FadeIn(
                      animation: Tween(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: const Interval((1 / 7) * 0, 1.0,
                              curve: Curves.fastOutSlowIn),
                        ),
                      ),
                      controller: _animationController,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Dont have an account? Join us",
                            style: GoogleFonts.electrolize(
                                fontWeight: FontWeight.w600,
                                color: black,
                                fontSize: 11.sp),
                          ),
                          Semantics(
                            button: true,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      duration: const Duration(seconds: 1),
                                      child: const SignUpScreen()),
                                );
                              },
                              borderRadius: BorderRadius.circular(5.r),
                              child: SizedBox(
                                height: 20.h,
                                width: 35.w,
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: black,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

enum ButtonState { init, loading, done }

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  ButtonState state = ButtonState.init;

  //textediting Controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late bool obsecureText;

  @override
  void initState() {
    obsecureText = false;
    super.initState();
  }

  void logIn() async {
    try {
      //try signin
      if (_emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty) {
        Dialogs.materialDialog(
            lottieBuilder: LottieBuilder.asset("assets/lottie/load2.json"),
            color: Colors.transparent,
            barrierColor: black.withOpacity(0.5),
            context: context);
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);

        if (mounted) Navigator.pop(context);
      } else {
        errorMessage("FILL ALL THE INFORMATION");
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'user-not-found') {
        errorMessage('NO USER ASSOCIATED WITH THIS EMAIL FOUND');
        if (mounted) Navigator.pop(context);
      } else if (e.code == 'wrong-password') {
        errorMessage('PASSWORD DOESNT MATCHED');
        if (mounted) Navigator.pop(context);
      } else {
        errorMessage("SOMETHING WENT WRONG");
      }
    }
  }

  void errorMessage(String message) {
    var snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        content: Text(
          message,
          style: GoogleFonts.electrolize(
              fontWeight: FontWeight.bold, fontSize: 11.sp, color: white),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
            controller: _emailController,
            hintText: "Email",
            obsecureText: false),
        SizedBox(
          height: 20.h,
        ),
        CustomTextField(
            controller: _passwordController,
            hintText: "PASSWORD",
            obsecureText: !obsecureText),
        SizedBox(
          height: 20.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Semantics(
              button: true,
              child: InkWell(
                hoverColor: grey.shade300,
                onTap: () {
                  setState(() {
                    obsecureText = !obsecureText;
                  });

                  log("Tapped Show Password !!");
                },
                borderRadius: BorderRadius.circular(5.r),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                  child: Text(
                    obsecureText ? "HIDE PASSWORD !" : "SHOW PASSWORD !",
                    style: GoogleFonts.electrolize(
                      fontWeight: FontWeight.bold,
                      color: black,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ),
            ),
            CustomActionSheet()
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        InkWell(
          onTap: () {
            logIn();
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            width: mq?.width.w,
            decoration: BoxDecoration(
                color: crimson,
                boxShadow: [
                  BoxShadow(
                      color: grey.shade500,
                      offset: Offset(4, 4),
                      spreadRadius: 1.r,
                      blurRadius: 12.r),
                  BoxShadow(
                      color: white,
                      offset: Offset(-4, -4),
                      spreadRadius: 1.r,
                      blurRadius: 12.r)
                ],
                borderRadius: BorderRadius.circular(12.r)),
            child: Center(
              child: Text(
                "Log In",
                style: GoogleFonts.electrolize(
                  fontWeight: FontWeight.bold,
                  color: white,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}

class CustomActionSheet extends StatefulWidget {
  const CustomActionSheet({super.key});

  @override
  State<CustomActionSheet> createState() => _CustomActionSheetState();
}

class _CustomActionSheetState extends State<CustomActionSheet> {
  final _forgotPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
          child: Text(
            "FORGOT PASSWORD ?",
            style: GoogleFonts.electrolize(
              fontWeight: FontWeight.bold,
              color: black,
              fontSize: 10.sp,
            ),
          ),
        ),
        onTap: () {
          showModalBottomSheet(
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
                              "Forgot Your Password ?",
                              style: GoogleFonts.electrolize(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                  color: black),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              "Enter your email address and we will share a link to create a new password",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.electrolize(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10.sp,
                                  color: black),
                            ),
                            SizedBox(
                              height: 14.h,
                            ),
                            CustomTextField(
                                controller: _forgotPassword,
                                hintText: "Enter Email",
                                obsecureText: false),
                            SizedBox(
                              height: 14.h,
                            ),
                            CustomButton(
                                onTap: () {
                                  log("Messges Sent");
                                },
                                padding: 10.h,
                                height: 40.h,
                                width: MediaQuery.of(context).size.width.w,
                                color: grey.shade200,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 15.h,
                                      width: 15.w,
                                      child: Center(
                                        child: Image.asset(
                                          "assets/images/send.png",
                                          color: purp,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      "Send",
                                      style: GoogleFonts.electrolize(
                                          fontWeight: FontWeight.bold,
                                          color: purp),
                                    )
                                  ],
                                ))
                          ],
                        )),
                  )),
                ]),
          );
        },
      ),
    );
  }
}
