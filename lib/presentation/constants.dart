import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

InputDecoration kTextFieldDecoration = InputDecoration(
    isDense: true,
    contentPadding: EdgeInsets.fromLTRB(13.w, 10.h, 0, 10.h),
    filled: true,
    fillColor: Colors.black38,
    hintText: 'Enter City Name',
    hintStyle: TextStyle(color: Colors.grey[500]),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0.r),
        ),
        borderSide: const BorderSide(color: Colors.grey)));