import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:totalxproject/utils/resposnive.dart';
import 'package:provider/provider.dart';
import 'package:totalxproject/controller/auth_provider.dart';
import 'package:totalxproject/view/listpage.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthenticationProvider>();

    return Scaffold(
       backgroundColor: Color(0xffFAFAFA),
       body: Container(
        width: Responsive.isMobile(context) ? 600 : 800,
        height: Responsive.isMobile(context) ? 1000 : 1000,
          child: Column(
            children: [
            SizedBox(height: 50.h,),
            Padding(
              padding: EdgeInsets.only(right:45.r),
              child: Text("Login or create an account",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600,fontSize: 18.sp),),
              ),
              SizedBox(height: 60.h),
              Text(
                "Welcome\nTOTAL-X",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff05609A),
                  fontSize: 28.sp,
                ),
              ),
              SizedBox(height: 40.h,),
              Center(
                child: Image.asset(
                  "assets/OBJECTS.png",
                ),
              ),
              SizedBox(height: 100.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ElevatedButton(
                          onPressed: authProvider.isLoading 
                        ? null 
                        : () async {
                            final userCredential = await authProvider.signInWithGoogle();
                            if (userCredential != null && userCredential.user != null) {
                              if (mounted) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const HomePage()),
                                );
                              }
                            }
                          },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:Color(0xffFAFAFA),
                    side: BorderSide(
                        color: Color(0xff00000066),
                        width: 1.w
                      ),
                    minimumSize: Size(300, 50.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: authProvider.isLoading
                    ? const CircularProgressIndicator()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            "assets/google.svg",
                            width: 24.w,
                            height: 24.w,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            "Continue with Google",
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              color: Colors.black
                            ),
                          ),
                        ],
                      ),
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RichText(
                text: TextSpan(
                  style: GoogleFonts.montserrat(
                    color: Colors.black, // default text color
                  ),
                  children: [
                    const TextSpan(text: "By Continuing, I Agree to TotalX's "),
                    
                    TextSpan(
                      text: "Terms and Conditions",
                      style: GoogleFonts.montserrat(
                        color: Colors.blue,
                        decoration: TextDecoration.underline, // optional
                      ),
                    ),

                    const TextSpan(text: " & "),

                    TextSpan(
                      text: "Privacy Policy",
                      style: GoogleFonts.montserrat(
                        color: Colors.blue,
                        decoration: TextDecoration.underline, // optional
                      ),
                    ),
                  ],
                ),
              ),
              )
            ],
          ),
        ),
      );
  }
}