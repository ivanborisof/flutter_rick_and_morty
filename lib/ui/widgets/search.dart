import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchWidget extends StatelessWidget {
  final Function(String) onChange;

  const SearchWidget({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.r),
      child: TextField(
        onChanged: onChange,
        style: TextStyle(color: Colors.white, fontSize: 25.sp),
        decoration: InputDecoration(
          isCollapsed: true,
          contentPadding: EdgeInsets.symmetric(vertical: 15.w),
          fillColor: const Color(0xff2D2D2D),
          filled: true,
          hintStyle: TextStyle(color: Color(0xff767676), fontSize: 25.sp),
          border: InputBorder.none,
          prefixIcon: Container(
            padding: EdgeInsets.only(left: 5.w),
            width: 24.w,
            child: Center(
              child: SvgPicture.asset(
                "assets/search.svg",
                width: 24.w,
              ),
            ),
          ),
          hintText: 'Ramamama Lord...',
        ),
      ),
    );
  }
}
