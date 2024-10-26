import 'package:chimeup/Screens/Home.dart';
import 'package:chimeup/Screens/widget/bottomnav.dart';
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../Utils/colors.dart';
import '../Utils/toast.dart';
import '../utils/utils.dart';
import 'package:vibration/vibration.dart';
import '../Resources/auth_methods.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _termsAccepted = false;

  final Utils utils = Utils();
  final Auth _authMethods = Auth();
  bool _isLoading = false;

  void showCustomToast(String message) {
    _triggerVibration();
    DelightToastBar(
      builder: (context) {
        return ToastCards(
          leading: const Icon(Icons.notifications_active, size: 32, color: Colors.red),
          title: message,
        );
      },
      position: DelightSnackbarPosition.top,
      snackbarDuration: const Duration(seconds: 5),
      autoDismiss: true,
    ).show(context);
  }

  void _triggerVibration() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 300);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
  
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
             begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        // ignore: prefer_const_literals_to_create_immutables
        colors: [
          Color(0xFF192038), // Navy blue shade
          Color(0xFF0F1523), // Darker shade
        ],

        )),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 150,),
                const Text('ChimeUp!', style: TextStyle(fontSize: 32, color: Colors.white,fontFamily: "GreatVibes", fontWeight: FontWeight.bold),),

                const SizedBox(height: 100,),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Colors.white,width: 2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Colors.white,width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Colors.white,width: 2),
                    ),
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
        
                // Email Field
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Colors.white,width: 2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Colors.white,width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Colors.white,width: 2),
                    ),
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    return null;
                  },
                ),
               
        
                // Phone Number Field with Country Flag and Code
                const SizedBox(height: 16),
        
                // Password Field
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Colors.white, width: 2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Colors.white, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Colors.white, width: 2),
                    ),
                    labelStyle: const TextStyle(color: Colors.white),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscurePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
        
                // Confirm Password Field
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Colors.white, width: 2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Colors.white, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Colors.white, width: 2),
                    ),
                    labelStyle: const TextStyle(color: Colors.white),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscureConfirmPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    } else if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
        
                // Terms and Conditions Checkbox
                Row(
                  children: [
                    Checkbox(
                      value: _termsAccepted,
                      onChanged: (bool? value) {
                        setState(() {
                          _termsAccepted = value!; // Ensure it's not null
                        });
                      },
                    ),
                    const Expanded(
                      child: Text(
                        'I agree to the terms and conditions',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
        
                const SizedBox(height: 16),
        
                // Sign Up Button
                Center(
                  child: _isLoading
                      ? const CircularProgressIndicator() // Show loader when loading
                      : SizedBox(
                        height: 70,
                        width: 200,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                            ),
                            onPressed: _termsAccepted
                                ? () async {
                                    if (_formKey.currentState!.validate()) {
                                      // Retrieve values from controllers
                                      String email = _emailController.text;
                                      String password = _passwordController.text;
                                      String username = _usernameController.text; // Ensure you have defined this controller
                                  
                                
                                      setState(() {
                                        _isLoading = true; // Start loading
                                      }); // Get the phone number stored from IntlPhoneField
                                
                                      // Check if phone number is empty or not valid
                                
                                
                                      try {
                                        await _authMethods.signUpWithEmailAndPassword(email, password, username);
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) =>const HomePage()),
                                        );
                                      } catch (e) {
                                        showCustomToast(e.toString());
                                      } finally {
                                        setState(() {
                                          _isLoading = false; // Stop loading
                                        });
                                      }
                                    }
                                  }
                                : null, // Disable button if terms not accepted
                            child: const Text("Sign Up", style: TextStyle(color: Colors.white),),
                          ),
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
