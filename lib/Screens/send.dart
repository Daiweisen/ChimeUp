import 'package:chimeup/Screens/transfer.dart';
import 'package:chimeup/Screens/widget/numeric_keypad.dart';
import 'package:chimeup/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Send extends StatefulWidget {
  const Send({super.key});

  @override
  State<Send> createState() => _SendState();
}

class _SendState extends State<Send> {
  // String to store the selected amount
  String selectedAmount = '';

  void onAmountSelected(String amount) {
    setState(() {
      selectedAmount = amount;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            padding: EdgeInsets.all(8.w), // Use ScreenUtil for responsive padding
            child: Column(
              children: [
                SizedBox(height: 40.h), // Use ScreenUtil for responsive height
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.1),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 90.w), // Use ScreenUtil for responsive width
                     Text('Send Money', style: TextStyle(color: Colors.white, fontSize: 18.sp)),
                    SizedBox(width: 90.w), // Use ScreenUtil for responsive width
                    CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.1),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h), // Use ScreenUtil for responsive height
                Container(
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(20.r), // Use ScreenUtil for responsive radius
                  ),
                  height: 80.h, // Use ScreenUtil for responsive height
                  width: 370.w, // Use ScreenUtil for responsive width
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(15.r), // Use ScreenUtil for responsive radius
                        ),
                        height: 50.h, // Use ScreenUtil for responsive height
                        width: 80.w, // Use ScreenUtil for responsive width
                        child: Center(
                          child: Image.asset(
                            'assets/mastercard.png',
                            width: 40.w, // Use ScreenUtil for responsive width
                            height: 40.h, // Use ScreenUtil for responsive height
                          ),
                        ),
                      ),
                      Text(
                        selectedAmount.isEmpty ? "Enter amount" : "₦$selectedAmount",
                        style: TextStyle(color: Colors.white, fontSize: 16.sp), // Use ScreenUtil for responsive font size
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 70.h), // Use ScreenUtil for responsive height
                SizedBox(
                  height: 470.h, // Use ScreenUtil for responsive height
                  width: 400.w, // Use ScreenUtil for responsive width
                  child: NumberPadScreen(
                    onAmountSelected: onAmountSelected, // Capture the amount
                  ),
                ),
                SizedBox(height: 20.h), // Use ScreenUtil for responsive height
                SizedBox(
                  height: 60.h, // Use ScreenUtil for responsive height
                  width: 250.w, // Use ScreenUtil for responsive width
                  child: ElevatedButton(
                   style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor, // Dark card color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r), // Use ScreenUtil for responsive radius
                      ),
                    ),
                    onPressed: selectedAmount.isEmpty
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TransferScreen(amount: selectedAmount),
                              ),
                            );
                          },
                    child: const Text('Proceed', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
