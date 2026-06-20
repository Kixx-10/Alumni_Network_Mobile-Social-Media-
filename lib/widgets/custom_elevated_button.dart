import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final double? fontSize;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 200.w,
      height: height ?? 50.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, 
          foregroundColor: Colors.white,       
          side: const BorderSide(color: Colors.white, width: 1.5), 
          elevation: 0, // အရိပ်ဖျောက်ရန်
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: fontSize ?? 16.sp),
        ),
      ),
    );
  }
}