import 'package:chimeup/Screens/forgotPassword.dart';
import 'package:chimeup/Screens/signup.dart';
import 'package:chimeup/Screens/widget/bottomnav.dart';
import 'package:chimeup/Utils/colors.dart';
import 'package:chimeup/Utils/toast.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:delightful_toast/delight_toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil

import '../Screens/home.dart';
import '../Resources/auth_methods.dart';
import 'package:vibration/vibration.dart';
import '../utils/utils.dart';
import 'widget/button.dart';

@immutable
class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final Utils utils = Utils();
  final Auth _authMethods = Auth();
  bool _obscurePassword = true; // Track password visibility
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
// Example usage in your sign-in logic
void handleSignInError(Exception e) {
  String errorMessage = getErrorMessage(e.toString());
  showCustomToast(errorMessage); // Use your toast function here
}

  void showCustomToast(errorMessage) {
    // Trigger vibration when showing the toast
    _triggerVibration();

    // Show the delightful toast message
    DelightToastBar(
      builder: (context) {
        return ToastCards(
          leading: const Icon(Icons.notifications_active, size: 23, color: Colors.red),
          title: errorMessage,
          
          
        );
      },
      position: DelightSnackbarPosition.top,
      snackbarDuration: const Duration(seconds: 5),
      autoDismiss: true,
    ).show(context);
  }

String getErrorMessage(String errorCode) {
  switch (errorCode) {
    case 'firebase_auth/invalid-email':
      return 'The email address is not formatted correctly. Please check and try again.';
    case 'firebase_auth/user-not-found':
      return 'No account found with this email. Please check or sign up.';
    case 'firebase_auth/wrong-password':
      return 'Incorrect password. Please try again.';
    // Add more cases as needed
    default:
      return 'An unexpected error occurred. Please try again.';
  }
}



  void _triggerVibration() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 300);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF192038),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30.h), // Adjusted with ScreenUtil
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
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: 20.h), // Adjusted with ScreenUtil
                    Container(
                      height: screenSize.height * 0.58,
                      padding: EdgeInsets.all(15.w), // Adjusted with ScreenUtil
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Welcome to ",
                                  style: TextStyle(
                                    fontSize: 16.sp, // Reduced font size
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "ChimeUp!",
                                  style: TextStyle(
                                    fontSize: 14.sp, // Reduced font size
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: "GreatVibes",
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h), // Adjusted with ScreenUtil
                          TextField(
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp, // Reduced font size
                            ),
                            controller: _emailController,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              icon: const Icon(Icons.mail_outlined, color: Colors.white),
                              labelText: "Enter Email",
                              labelStyle: const TextStyle(color: Colors.white, fontSize: 14), // Reduced font size
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.white, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.white, width: 2),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h), // Adjusted with ScreenUtil
                          TextField(
                            controller: _passwordController,
                            obscureText: _obscurePassword, // Use the visibility state
                            decoration: InputDecoration(
                              icon: const Icon(Icons.lock_outlined, color: Colors.white),
                              labelText: "Enter Password",
                              labelStyle: const TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Poppins'), // Reduced font size
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword; // Toggle visibility
                                  });
                                },
                                icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off, color: Colors.white),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.white, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: const BorderSide(color: Colors.white, width: 2),
                              ),
                            ),
                            style: const TextStyle(fontSize: 14, color: Colors.white), // Reduced font size
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 200),
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const Forgotscreen(), // Replace with your Forgot Password screen
                                  ),
                                ),
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(fontSize: 14, color: Colors.white), // Reduced font size
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.h), // Adjusted with ScreenUtil
                          Center(
                            child: _isLoading
                                ? const CircularProgressIndicator(color: Colors.white) // Show loader when loading
                                : CustomButton(
                                    color: buttonColor,
                                    isLoading: false,
                                    onPressed: () async {
                                      setState(() {
                                        _isLoading = true; // Start loading
                                      });
                                      try {
                                        String output = await _authMethods.loginUserWithEmailAndPassword(
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                        );
                                        if (output == "success") {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => const HomePage(),
                                            ),
                                          );
                                        } else {
                                          showCustomToast(output);
                                        }
                                      } catch (e) {
                                        print('Error: $e');
                                        showCustomToast('An error occurred during sign-in.');
                                      } finally {
                                        setState(() {
                                          _isLoading = false; // Stop loading
                                        });
                                      }
                                    },
                                    child: const Text(
                                      "Sign In",
                                      style: TextStyle(
                                        fontSize: 14, // Reduced font size
                                        letterSpacing: 0.8,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  fontSize: 14.0, // Reduced font size
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 5),
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpPage(), // Replace with your Signup screen
                                  ),
                                ),
                                child: Text(
                                  'Signup.',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14, // Reduced font size
                                    color: buttonColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.h), // Adjusted with ScreenUtil
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Need help? Visit our ",
                          style: TextStyle(fontSize: 14.0, color: Colors.white), // Reduced font size
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'help centre',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14, // Reduced font size
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
