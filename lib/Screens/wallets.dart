import 'package:chimeup/Screens/widget/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Rate extends StatefulWidget {
  const Rate({super.key});

  @override
  State<Rate> createState() => _RateState();
}

class _RateState extends State<Rate> {
  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil
    ScreenUtil.init(
      context,
      designSize: const Size(360, 690), // Adjust as per your design size
      minTextAdapt: true,
      splitScreenMode: true,
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF192038), // Navy blue shade
                Color(0xFF0F1523), // Darker shade
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.w), // Use ScreenUtil for padding
            child: Column(
              children: [
                const SizedBox(height: 40),
                Row(
                  children: [
                    const SizedBox(width: 0),
                    CircleAvatar(
                      
                      backgroundColor: Colors.white.withOpacity(0.1),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          
                          color: Colors.white,
                        ),
                      ),
                    ),
                     SizedBox(width: 100.w),
                    Text(
                      'Wallets',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp, // Use ScreenUtil for font size
                      ),
                    ),
                    SizedBox(width: 100.w),
                    CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.1),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                SizedBox(
                  height: 300.h, // Use ScreenUtil for height
                  width: 500.w, // Use ScreenUtil for width
                  child: const BlurryCardBTC(),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 300.h, // Use ScreenUtil for height
                  width: 500.w, // Use ScreenUtil for width
                  child: const BlurryCardGBP(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
