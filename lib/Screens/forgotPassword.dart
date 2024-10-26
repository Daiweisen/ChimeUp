
import 'package:chimeup/Screens/signin.dart';
import 'package:chimeup/Utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/utils.dart';
import 'package:get/get.dart';

import 'widget/button.dart';

@immutable
class Forgotscreen extends StatefulWidget {
  const Forgotscreen({super.key});

  @override
  State<Forgotscreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<Forgotscreen> {
  final _forgotPasswordController = TextEditingController();
  final Utils utils = Utils();

  @override
  void dispose() {
    _forgotPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              // ignore: prefer_const_literals_to_create_immutables
              colors: [
                Color(0xFF192038),
                Color(0xFF0F1523),
              ],
            ),
          ),
          child: SizedBox(
            height: screenSize.height ,
            width: screenSize.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Center(
                child: Column(
                  
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    const SizedBox(height: 30),
                    Container(
                      height: screenSize.height * 0.58,
                      // width: screenSize.width * 0.8,
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                           Center(
                            child: Text(
                              "Forgot password",
                              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color:buttonColor),
                            ),
                          ),
                          const Center(
                            child: Text(
                              "Reset using email",
                              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                          
                          
                          const SizedBox(height: 20),
                          TextField(
                            controller: _forgotPasswordController,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              icon: const Icon(Icons.mail_outlined, color: Colors.white,),
                              labelText: "Enter Email",
                              labelStyle: const TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.white, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white, width: 2),
              ),
                            ),
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                         
                          
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                             
                              CustomButton2(
                                color: buttonColor,
                                isLoading: false,
                                onPressed: () async {
                                   var forgotEmail = _forgotPasswordController.text.trim();
          
                      try {
                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(email: forgotEmail)
                            .then((value) {
                                  // Show success message using ScaffoldMessenger
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text("Email Sent"),
                                      backgroundColor: buttonColor, // Customize the color
                                   ),
                                  );
                                  // Navigate to the login screen
                                  Get.off(() => const SigninScreen());
                                });
                      } on FirebaseAuthException catch (e) {
                        print("Error $e");
                        // Optionally, show an error message here as well
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Error: ${e.message}"),
                            backgroundColor: buttonColor, // Customize the color
                          ),
                        );
                      }
          
                                },
                                child: const Text("Submit", style: TextStyle(fontSize: 16, letterSpacing: 0.8, color: Colors.white, fontWeight: FontWeight.w600)),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                               CustomButton2(
                                color: Colors.white,
                                isLoading: false,
                                onPressed: () async {
                                },
                                child:  Text("Cancel", style: TextStyle(fontSize: 16, letterSpacing: 0.8, color: buttonColor, fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 5),
                         
                      
                              
                        ],
                      ),
                    ),
                       Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Need help? Visit our ",
                                style: TextStyle(fontSize: 14.0,  color: Colors.white),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child:  Text('help centre', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color:buttonColor)),
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
