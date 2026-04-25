import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:totalxproject/controller/user_provider.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sort",
              style: GoogleFonts.montserrat(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 15.h),
            _buildOption(context, "All", UserFilter.all),
            _buildOption(context, "Age: Below 60", UserFilter.below60),
            _buildOption(context, "Age: Above 60", UserFilter.above60),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(BuildContext context, String label, UserFilter filter) {
    final currentFilter = context.watch<UserProvider>().currentFilter;
    return InkWell(
      onTap: () {
        context.read<UserProvider>().setFilter(filter);
        Navigator.pop(context);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            Container(
              height: 20.w,
              width: 20.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.blue,
                  width: 2.w,
                ),
              ),
              child: Center(
                child: Container(
                  height: 10.w,
                  width: 10.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentFilter == filter ? Colors.blue : Colors.transparent,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              label,
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
