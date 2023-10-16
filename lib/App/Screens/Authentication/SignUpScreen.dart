import 'package:ENEB_HUB/App/Screens/Authentication/LoginScreen.dart';
import 'package:ENEB_HUB/Widgets/CustomExit.dart';
import 'package:ENEB_HUB/Widgets/LoginTextField.dart';
import 'package:ENEB_HUB/Widgets/customWillPopScope.dart';
import 'package:ENEB_HUB/constant/Animations/WidgetFadeAnimation.dart';
import 'package:ENEB_HUB/constant/Styles/Colors.dart';
// import 'package:ENEB_HUB/core/Controllers/Resources/Authentication.dart';
import 'package:ENEB_HUB/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:page_transition/page_transition.dart';

// import 'package:password_field_validator/password_field_validator.dart';

class SignUpScreen extends StatefulWidget {
  final Function()? onTap;

  const SignUpScreen({
    Key? key,
    this.onTap,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

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
      duration: Duration(
        milliseconds: 1000,
      ),
    );

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width.w;

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
                                  curve: Interval((1 / 7) * 0, 1.0,
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
                                  curve: Interval((1 / 7) * 0, 1.0,
                                      curve: Curves.fastOutSlowIn),
                                ),
                              ),
                              controller: _animationController,
                              child: Text(
                                "Join us to start learning",
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold,
                                  color: black,
                                  fontSize: 26.sp,
                                ),
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
                                  curve: Interval((1 / 7) * 0, 1.0,
                                      curve: Curves.fastOutSlowIn),
                                ),
                              ),
                              controller: _animationController,
                              child: Text(
                                "Discover your perfect topic and start exploring them",
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
                                  curve: Interval((1 / 7) * 0, 1.0,
                                      curve: Curves.fastOutSlowIn),
                                ),
                              ),
                              controller: _animationController,
                              child: SignUpForm()),
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
                          curve: Interval((1 / 7) * 0, 1.0,
                              curve: Curves.fastOutSlowIn),
                        ),
                      ),
                      controller: _animationController,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Already have an account? Login now",
                            style: GoogleFonts.electrolize(
                                fontWeight: FontWeight.w600,
                                color: black,
                                fontSize: 11.sp),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    duration: Duration(seconds: 1),
                                    child: LoginScreen()),
                              );
                            },
                            borderRadius: BorderRadius.circular(5.r),
                            child: SizedBox(
                              height: 20.h,
                              width: 35.w,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: black,
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

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  //textediting Controllers
  final _nameController = TextEditingController();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late bool tick1;
  late bool tick2;

  @override
  void initState() {
    tick1 = false;
    tick2 = false;
    super.initState();
  }

  void Register() async {
    try {
      //show loading animations

      if (_emailController.text.isNotEmpty &&
          _nameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty) {
        Dialogs.materialDialog(
            lottieBuilder: LottieBuilder.asset("assets/lottie/load2.json"),
            color: Colors.transparent,
            barrierColor: black.withOpacity(0.5),
            context: context);

        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text)
            .then((value) => {
                  _firestore
                      .collection("user")
                      .doc(_auth.currentUser!.uid)
                      .set({
                    "userName": _nameController.text,
                    "email": _emailController.text,
                    "uid": _auth.currentUser!.uid
                  })
                });
        if (mounted) Navigator.pop(context);
      } else {
        errorMessage("ENTER ALL THE INFORMATION");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorMessage('Password is too weak');
      } else if (e.code == 'email-already-in-use') {
        errorMessage('THIS ACCOUNT ALREADY EXISTS');
      }
    } catch (e) {
      print(e);
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
          controller: _nameController,
          hintText: "NAME",
          obsecureText: false,
        ),
        SizedBox(
          height: 20.h,
        ),
        CustomTextField(
            controller: _emailController,
            hintText: "EMAIL",
            obsecureText: false),
        SizedBox(
          height: 20.h,
        ),
        CustomTextField(
            controller: _passwordController,
            hintText: "PASSWORD",
            obsecureText: false),
        SizedBox(
          height: 20.h,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              tick1 = !tick1;
            });
          },
          child: Row(
            children: [
              Container(
                height: 20.h,
                width: 20.w,
                padding: EdgeInsets.all(3.sp),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: black, width: 1.r)),
                child: Center(
                    child: tick1
                        ? Image.asset("assets/images/check.png")
                        : SizedBox()),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Text(
                  "I agree with the Terms of Privacy Policy",
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      color: black,
                      fontSize: 11.sp),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        GestureDetector(
          onTap: () {
            tick1
                ? Register()
                : errorMessage("PLEASE ACCEPT THE PRIVACY POLICY TO CONTINUE");
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "JOIN US",
                    style: GoogleFonts.electrolize(
                      fontWeight: FontWeight.bold,
                      color: white,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
