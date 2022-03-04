import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReusableTextCard extends StatelessWidget {
  const ReusableTextCard({
    Key? key, required this.widget
  }) : super(key: key);

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.85.sw,
      height: 0.1.sh,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r),
        color: const Color(0xffffffff).withOpacity(0.7),
      ),
      child: Center(child: widget),
    );
  }
}