import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:totalxproject/controller/auth_provider.dart';
import 'package:totalxproject/controller/user_provider.dart';
import 'package:totalxproject/utils/resposnive.dart';
import 'package:totalxproject/view/widgets/add_user_dialog.dart';
import 'package:totalxproject/view/widgets/filter_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Container(
        width: Responsive.isMobile(context) ? 600 : 800,
        height: Responsive.isMobile(context) ? 1000 : 1000, 
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 60.h,
              decoration: BoxDecoration(
                color: Color(0xff100E09)
              ),
              child: Row(
                children: [
                  SizedBox(width: 20.w,),
                  Icon(Icons.location_on,color: Colors.white,),
                  SizedBox(width: 10.w,),
                  Text("Nilambur",style: GoogleFonts.montserrat(color: Colors.white,fontSize: 16.sp),),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/1.2,
              decoration: BoxDecoration(
                color: Color(0xffEBEBEB)
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: Color.fromARGB(255, 149, 149, 149),
                                width: 1.w
                              )
                            ),
                            child: TextField(
                              onChanged: (value) {
                                context.read<UserProvider>().setSearchQuery(value);
                              },
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: Icon(Icons.search, color: Colors.grey,),
                                hintText: "Search by name",
                                hintStyle: GoogleFonts.montserrat(
                                  color: Colors.grey,
                                  fontSize: 14.sp
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 8.h)
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w,),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => const FilterDialog(),
                            );
                          },
                          child: SvgPicture.asset(
                            'assets/filter.svg',
                            width: 30.w,
                            height: 30.h,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Users List",
                        style: GoogleFonts.montserrat(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    Expanded(
                      child: Consumer<UserProvider>(
                        builder: (context, userProvider, child) {
                          return ListView.builder(
                            itemCount: userProvider.users.length,
                            padding: EdgeInsets.only(bottom: 20.h),
                            itemBuilder: (context, index) {
                              final user = userProvider.users[index];
                              return Container(
                                margin: EdgeInsets.only(bottom: 12.h),
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 10,
                                      offset: Offset(0, 4)
                                    )
                                  ]
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 30.r,
                                      backgroundImage: NetworkImage(user.image),
                                    ),
                                    SizedBox(width: 15.w,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user.name,
                                          style: GoogleFonts.montserrat(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black
                                          ),
                                        ),
                                        SizedBox(height: 4.h,),
                                        Text(
                                          "Age: ${user.age}",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black54
                                          ),
                                        ),
                                        SizedBox(height: 2.h,),
                                        Text(
                                          "Phone: ${user.phoneNumber}",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black45
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => const AddUserDialog(),
        );
      },
      child: const Icon(Icons.add, color: Colors.white),
      backgroundColor: Colors.black,
      shape: const CircleBorder(),
    ),
  );
}
}