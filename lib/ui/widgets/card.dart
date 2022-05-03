import 'package:flutter/material.dart';
import 'package:flutter_rick_and_morty/data/models/character.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardWidget extends StatelessWidget {
  final Charter charter;
  const CardWidget({
    Key? key,
    required this.charter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _identifyColorOfMug() {
      if (charter.status == "Alive") {
        return const Color(0xff3CAA3A);
      } else if (charter.status == "unknown") {
        return Colors.grey;
      } else {
        return Colors.red;
      }
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(15.r),
      child: Container(
        color: const Color(0xff2D2D2D),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.network(
                  charter.image,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15.h),
                      Text(
                        charter.name,
                        style: TextStyle(
                          fontSize: 30.sp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Container(
                            width: 7.w,
                            height: 7.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.r),
                              color: _identifyColorOfMug(),
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Flexible(
                            child: Text(
                              charter.status + " - " + charter.species,
                              style: TextStyle(
                                fontSize: 17.sp,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Last known location:",
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: const Color(0xff909090),
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            charter.location,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "First seen in:",
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: const Color(0xff909090),
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            charter.firstSeen.toString(),
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 15.w),
            ],
          ),
        ),
      ),
    );
  }
}
