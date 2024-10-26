// import 'dart:async';
// import 'dart:ui';
// import 'dart:math'; // Import dart:math
// import 'package:flutter/material.dart';

// class BlurryCard extends StatefulWidget {
//   const BlurryCard({super.key});

//   @override
//   _BlurryCardState createState() => _BlurryCardState();
// }

// class _BlurryCardState extends State<BlurryCard> {
//   Color _shadowColor = Colors.blue; // Initial shadow color
//   Timer? _timer;

//   @override
//   void initState() {
//     super.initState();
//     _startColorChange();
//   }

//   void _startColorChange() {
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       setState(() {
//         // Generate a random color
//         _shadowColor = Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel(); // Cancel the timer when the widget is disposed
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center, // Center align the contents
//       children: [
//         // Circular container 1
//         Positioned(
//           left: -50, // Adjust position to make it partially outside
//           top: -50,
//           child: Container(
//             width: 500,
//             height: 300,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.blue.withOpacity(0.3), // Color of the first circle
//             ),
//           ),
//         ),
//         // Circular container 2
//         Positioned(
//           right: -50, // Adjust position to make it partially outside
//           bottom: -50,
//           child: Container(
//             width: 300,
//             height: 300,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.red.withOpacity(0.3), // Color of the second circle
//             ),
//           ),
//         ),
//         // Blurry Card
//         ClipRect(
//           child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0), // Blur effect
//             child: Container(
//               width: 300,
//               height: 200,
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.2), // More transparent for glass effect
//                 borderRadius: BorderRadius.circular(15),
//                 border: Border.all(color: Colors.white.withOpacity(0.5), width: 1.5), // Optional border for glass effect
//                 boxShadow: [
//                   BoxShadow(
//                     color: _shadowColor.withOpacity(0.5), // Use the changing shadow color
//                     blurRadius: 20.0,
//                     spreadRadius: 5.0,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: const Center(
//                 child: Text(
//                   'Blurry Card',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }


import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import '../../Utils/colors.dart';

class BlurryCardBTC extends StatelessWidget {
  const BlurryCardBTC({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          height: 400.h, // ScreenUtil for height
          width: 500.w, // ScreenUtil for width
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0.r), // ScreenUtil for radius
            color: Colors.white.withOpacity(0.1),
            border: Border.all(
              color: Colors.white.withOpacity(0.03),
              width: 1.5.w, // ScreenUtil for border width
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 10.h), // ScreenUtil for spacing
              Text(
                'Bitcoin',
                style: TextStyle(color: Colors.white, fontSize: 13.sp), // Reduced font size
              ),
              SizedBox(height: 20.h), // ScreenUtil for spacing
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.1),
                    child: const Icon(Icons.currency_bitcoin_outlined, color: Colors.white),
                  ),
                  SizedBox(height: 20.h), // ScreenUtil for spacing
                  Text(
                    '1 BTC = 68,426.76 USD',
                    style: TextStyle(fontSize: 13.sp, color: Colors.white), // Reduced font size
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r), // ScreenUtil for radius
                      ),
                    ),
                    child: Text('Transfer', style: TextStyle(color: Colors.white, fontSize: 13.sp)), // Reduced font size
                  ),
                ],
              ),
              SizedBox(height: 140.h), // ScreenUtil for spacing
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Balance:', style: TextStyle(color: Colors.white70, fontSize: 13.sp)), // Reduced font size
                  Text(
                    ' 567.678 BTC',
                    style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.bold), // Reduced font size
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      side: BorderSide(color: Colors.white, width: 1.w), // ScreenUtil for border width
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r), // ScreenUtil for radius
                      ),
                    ),
                    child: Text('MAX', style: TextStyle(color: Colors.white, fontSize: 13.sp)), // Reduced font size
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BlurryCardGBP extends StatelessWidget {
  const BlurryCardGBP({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          height: 400.h, // ScreenUtil for height
          width: 500.w, // ScreenUtil for width
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0.r), // ScreenUtil for radius
            color: Colors.white.withOpacity(0.1),
            border: Border.all(
              color: Colors.white.withOpacity(0.03),
              width: 1.5.w, // ScreenUtil for border width
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 10.h), // ScreenUtil for spacing
              Text(
                'Pound',
                style: TextStyle(color: Colors.white, fontSize: 13.sp), // Reduced font size
              ),
              SizedBox(height: 20.h), // ScreenUtil for spacing
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.1),
                    child: const Icon(Icons.currency_pound_outlined, color: Colors.white),
                  ),
                  SizedBox(height: 20.h), // ScreenUtil for spacing
                  Text(
                    '1 USD = 0.77 GBP',
                    style: TextStyle(fontSize: 13.sp, color: Colors.white), // Reduced font size
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r), // ScreenUtil for radius
                      ),
                    ),
                    child: Text('Transfer', style: TextStyle(color: Colors.white, fontSize: 13.sp)), // Reduced font size
                  ),
                ],
              ),
              SizedBox(height: 140.h), // ScreenUtil for spacing
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Balance:', style: TextStyle(color: Colors.white70, fontSize: 13.sp)), // Reduced font size
                  Text(
                    ' 226.00 GBP',
                    style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.bold), // Reduced font size
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      side: BorderSide(color: Colors.white, width: 1.w), // ScreenUtil for border width
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r), // ScreenUtil for radius
                      ),
                    ),
                    child: Text('MAX', style: TextStyle(color: Colors.white, fontSize: 13.sp)), // Reduced font size
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
