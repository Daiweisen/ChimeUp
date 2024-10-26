import 'dart:ui';
import 'package:chimeup/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart'; // Import intl package for number formatting

class NumberPadScreen extends StatefulWidget {
  final Function(String) onAmountSelected; // Add this line

  const NumberPadScreen({super.key, required this.onAmountSelected}); // Add this line

  @override
  _NumberPadScreenState createState() => _NumberPadScreenState();
}

class _NumberPadScreenState extends State<NumberPadScreen> {
  String _output = ''; // To hold the tapped number output

  // Formatter to insert commas for large numbers
  final NumberFormat _numberFormat = NumberFormat('#,##0', 'en_US');
  
  // Define a limit for the number of digits
  final int _maxDigits = 6;

  // Function to update the tapped number
  void _onNumberTapped(String number) {
    // Check if current length exceeds the limit before appending
    if (_output.replaceAll(',', '').length < _maxDigits) {
      setState(() {
        _output += number; // Append the number to the output
        _output = _formatWithCommas(_output); // Format with commas
      });
    }
  }

  // Function to clear the entire output
  void _clearOutput() {
    setState(() {
      _output = ''; // Clear the output
    });
  }

  // Function to remove the last digit (backspace)
  void _backspace() {
    setState(() {
      if (_output.isNotEmpty) {
        _output = _output.replaceAll(',', ''); // Remove commas temporarily
        _output = _output.substring(0, _output.length - 1); // Remove last character
        _output = _formatWithCommas(_output); // Reformat with commas
      }
    });
  }

  // Function to format the number with commas
  String _formatWithCommas(String number) {
    if (number.isEmpty) return '';
    try {
      return _numberFormat.format(int.parse(number)); // Format number with commas
    } catch (e) {
      return number; // In case the number isn't valid
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0.r, sigmaY: 5.0.r), // Blur effect
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0.r),
            color: Colors.white.withOpacity(0.05), // Slight white transparency
            border: Border.all(
              color: Colors.white.withOpacity(0.05), // Border to enhance glass look
              width: 1.5.w,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display the tapped numbers with comma formatting
              Padding(
                padding: EdgeInsets.all(20.0.w),
                child: Text(
                  _output.isEmpty ? '\₦0.0' : '\₦$_output',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              // Create a GridView for the number buttons
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 3 buttons in each row
                    childAspectRatio: 1.9, // Aspect ratio of the buttons
                  ),
                  itemCount: 12, // 0-9 numbers + clear + backspace button
                  itemBuilder: (context, index) {
                    // Determine the button's label
                    String label;
                    IconData? icon;
                    if (index < 9) {
                      label = '${index + 1}'; // 1-9 buttons
                    } else if (index == 9) {
                      label = 'Clear'; // Clear button
                    } else if (index == 10) {
                      label = '0'; // 0 button
                    } else {
                      icon = Icons.backspace; // Backspace icon
                      label = ''; // No text for backspace
                    }

                    // Return the button widget
                    return Padding(
                      padding: EdgeInsets.all(6.0.w),
                      child: ElevatedButton(
                        onPressed: label == 'Clear'
                            ? _clearOutput // Clear the output when 'Clear' is pressed
                            : icon != null
                                ? _backspace // Backspace when icon is tapped
                                : () => _onNumberTapped(label), // Tap number
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.1), // Dark card color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          padding: EdgeInsets.all(8.w), // Make button bigger
                        ),
                        child: label.isEmpty
                            ? Icon(icon, size: 20.sp, color: Colors.white) // Icon for backspace
                            : Text(
                                label,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                height: 60.h,
                width: 250.w,
                child: ElevatedButton(
                  onPressed: () {
                    widget.onAmountSelected(_output); // Pass the selected amount
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor, // Dark card color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  child: Text(
                    'Send \₦$_output',
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                ),
              ),
              SizedBox(height: 30.h)
            ],
          ),
        ),
      ),
    );
  }
}
