import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Utils/colors.dart';

class BannerScreen2 extends StatefulWidget {
  const BannerScreen2({super.key});

  @override
  _BannerScreen2State createState() => _BannerScreen2State();
}

class _BannerScreen2State extends State<BannerScreen2> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<BannerAd2> _banners = [

    const BannerAd2(
      color:Color(0xFFFF6F61),
      title: 'Current Balance',
      subtitle: '\₦ 5,000.00',
    ),
    BannerAd2(
      color: buttonColor,
      title:  'Current Balance',
      subtitle: '\₦ 5,000.00',
    ),
    const BannerAd2(
      color: Color(0xFF00BFA5),
      title:  'Current Balance',
      subtitle: '\₦ 5,000.00',
    ),
   
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _banners.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.w, // Card-like width
      height: 160.h, // Card-like height
      child: PageView(
        controller: _controller,
        children: _banners, // Dynamically add banners
      ),
    );
  }
}

class BannerAd2 extends StatelessWidget {
  final Color color;
  final String title;
  final String subtitle;

  const BannerAd2({
    super.key,
    required this.color,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        color: color, // Use the color instead of an image
        width: double.infinity,
        height: double.infinity,
        child: Column(
      
          children: [
             SizedBox(height: 20.h,),
            Row(
              children: [
                 SizedBox(width: 30.w,),
                Text(
                  title,
                  style:  TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          
            Row(
              children: [
                   SizedBox(width: 30.w,),
                Text(
                  subtitle,
                  style:  TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
             SizedBox(height: 20.h,),
            Row(children: [
               SizedBox(width: 20.w,),
               Text('*******64474', style: TextStyle(color: Colors.white70, fontSize: 14.sp),),
               SizedBox(width: 220.w,),
              Image.asset('assets/mastercard.png', height: 40.h, width: 30.w,),
            ],)
          ],
        ),
      ),
    );
  }
}
