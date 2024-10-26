import 'package:chimeup/Screens/newPassword.dart';
import 'package:chimeup/Screens/send.dart';
import 'package:chimeup/Screens/signin.dart';
import 'package:chimeup/Screens/widget/history.dart';
import 'package:chimeup/Screens/widget/home_card.dart';
import 'package:chimeup/Utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Resources/auth_methods.dart';
import 'wallets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController controller = ScrollController();
  double offset = 0;
  String firstName = ''; // Store user's first name
  String email = '';

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        offset = controller.position.pixels;
      });
    });
    fetchUserFirstName(); // Fetch user's first name
  }

  @override
  void dispose() {
    controller.dispose(); // Dispose the controller here
    super.dispose();
  }

  // Fetch user's first name from Firestore
  Future<void> fetchUserFirstName() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    print("Current User: $currentUser"); // Debugging line
    if (currentUser != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();
      
      // Ensure that userDoc exists
      if (userDoc.exists) {
        print("User Document: ${userDoc.data()}"); // Debugging line

        // Cast userDoc.data() to Map<String, dynamic>
        final userData = userDoc.data() as Map<String, dynamic>?;

        // Check if userData is not null before accessing
        if (userData != null && userData.containsKey('username')) {
          setState(() {
            firstName = userData['username'] ?? 'Guest'; // Provide a default value
            email = currentUser.email ?? 'Guest';
          });
        } else {
          print("Username field is not available."); // Debugging line
          setState(() {
            firstName = 'Guest'; // Default value if username is not available
          });
        }
      } else {
        print("User document does not exist."); // Debugging line
        setState(() {
          firstName = 'Guest'; // Default value if no user document
        });
      }
    } else {
      print("No user logged in."); // Debugging line
      setState(() {
        firstName = 'Guest'; // Default value if no user
      });
    }
  }

  @override
  Widget build(BuildContext context) {
  String firstLetter = firstName.isNotEmpty ? firstName[0].toUpperCase() : 'A';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: buttonColor,
         iconTheme: IconThemeData(
    color: Colors.white, // Change this to your desired color
  ),
      ),
       drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: buttonColor,
                
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                                   CircleAvatar(
                    radius: 30.r,
                    backgroundColor: Colors.blueAccent,
                    child: Text(
                      firstLetter,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Text('Welcome ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                          )),
                                                Text(firstName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                          )),
                    ],
                  ),
                  Text(email,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12.sp,
                      )),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home_filled),
              title: Text('Home', style: TextStyle(color: Colors.black87, fontSize: 14.sp),),
              onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const HomePage(), // Replace with your Send screen
                              ),
                            ),
            ),
            ListTile(
              leading: Icon(Icons.account_balance_wallet_outlined),
              title: Text('Wallets',style: TextStyle(color: Colors.black87, fontSize: 14.sp),),
             onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const Rate(), // Replace with your Send screen
                              ),
                            ),

            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Edit Profile',style: TextStyle(color: Colors.black87, fontSize: 14.sp),),
               onTap: () {
                Navigator.pop(context);
                _showEditProfileDialog(context);
              },         ),
             ListTile(
              leading: Icon(Icons.lock_outline),
              title: Text('Change Password',style: TextStyle(color: Colors.black87, fontSize: 14.sp),),
onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const NewPassword(), // Replace with your Send screen
                              ),
                            ),
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red,),
              title: Text('Logout', style: TextStyle(color: Colors.red, fontSize: 14.sp),),
             onTap: () async {
        
           Auth().signOut(); 
         if (context.mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const SigninScreen()),
            );
          }
      },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              // ignore: prefer_const_literals_to_create_immutables
              colors: [
                Color(0xFF192038), // Navy blue shade
                Color(0xFF0F1523), // Darker shade
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0.w), // Use ScreenUtil for padding
            child: Column(
              children: [
                SizedBox(height: 20.h), // Use ScreenUtil for height
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 25.r, // Use ScreenUtil for radius
                      child: Icon(
                        Icons.person_2_outlined,
                        color: Colors.white,
                      ),
                      backgroundColor: buttonColor,
                    ),
                    SizedBox(width: 20.w), // Use ScreenUtil for width
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Welcome!",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 18.sp, // Use ScreenUtil for font size
                              ),
                            ),
                          ],
                        ),
                        Text(
                          firstName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp, // Use ScreenUtil for font size
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 165.w), // Use ScreenUtil for width
                    Padding(
                      padding: EdgeInsets.only(right: 8.0.w), // Use ScreenUtil for padding
                      child: Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0.1),
                            radius: 18.r, // Use ScreenUtil for radius
                            child: Icon(
                              Icons.notifications_outlined, // Bell icon inside the circle
                              color: Colors.white,
                              size: 25.sp, // Use ScreenUtil for icon size
                            ),
                          ),
                          // Red dot (positioned at the top-right)
                          Positioned(
                            top: 2.h, // Use ScreenUtil for height
                            right: 2.w, // Use ScreenUtil for width
                            child: Container(
                              width: 10.w, // Use ScreenUtil for width
                              height: 10.h, // Use ScreenUtil for height
                              decoration: BoxDecoration(
                                color: buttonColor, // Red color for the dot
                                shape: BoxShape.circle, // Circular shape
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h), // Use ScreenUtil for height
                Row(
                  children: [
                    Text(
                      'Total Balance',
                      style: TextStyle(color: Colors.white70, fontSize: 16.sp), // Use ScreenUtil for font size
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '\₦ 5,000.00',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp, // Use ScreenUtil for font size
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h), // Use ScreenUtil for height
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 30.r, // Use ScreenUtil for radius
                          child: IconButton(
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const Send(), // Replace with your Send screen
                              ),
                            ),
                            icon: Image.asset(
                              'assets/send.png', // Replace with your image path
                              width: 24.0.w, // Use ScreenUtil for width
                              color: Colors.white, // Set width for the icon
                              height: 24.0.h, // Use ScreenUtil for height
                            ),
                          ),
                          backgroundColor: buttonColor,
                        ),
                        SizedBox(height: 5.h), // Use ScreenUtil for height
                        Text(
                          'Send',
                          style: TextStyle(color: Colors.white70, fontSize: 14.sp), // Use ScreenUtil for font size
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 30.r, // Use ScreenUtil for radius
                          child: IconButton(
                            onPressed: () {},
                            icon: Image.asset(
                              'assets/receive.png', // Replace with your image path
                              width: 24.0.w, // Use ScreenUtil for width
                              color: Colors.white, // Set width for the icon
                              height: 24.0.h, // Use ScreenUtil for height
                            ),
                          ),
                          backgroundColor: Colors.white.withOpacity(0.1),
                        ),
                        SizedBox(height: 5.h), // Use ScreenUtil for height
                        Text(
                          'Receive',
                          style: TextStyle(color: Colors.white70, fontSize: 14.sp), // Use ScreenUtil for font size
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 30.r, // Use ScreenUtil for radius
                          child: IconButton(
                            onPressed: () {},
                            icon: Image.asset(
                              'assets/card.png', // Replace with your image path
                              width: 24.0.w, // Use ScreenUtil for width
                              color: Colors.white, // Set width for the icon
                              height: 24.0.h, // Use ScreenUtil for height
                            ),
                          ),
                          backgroundColor: Colors.white.withOpacity(0.1),
                        ),
                        SizedBox(height: 5.h), // Use ScreenUtil for height
                        Text(
                          'Buy',
                          style: TextStyle(color: Colors.white70, fontSize: 14.sp), // Use ScreenUtil for font size
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 30.r, // Use ScreenUtil for radius
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.swap_horiz_rounded, size: 27.sp, color: Colors.white), // Use ScreenUtil for icon size
                          ),
                          backgroundColor: Colors.white.withOpacity(0.1),
                        ),
                        SizedBox(height: 5.h), // Use ScreenUtil for height
                        Text(
                          'Exchange',
                          style: TextStyle(color: Colors.white70, fontSize: 14.sp), // Use ScreenUtil for font size
                        ),
                     ],
                    ),
                  ],
                ),
                SizedBox(height: 10.h), // Use ScreenUtil for height
                  SizedBox( width: 400.w ,child: BannerScreen2()),
                SizedBox(height: 10.h), // Use ScreenUtil for height
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0.w), // Use ScreenUtil for padding
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.0.h), // Use ScreenUtil for padding
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20.r), // Use ScreenUtil for radius
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'History',
                              style: TextStyle(
                                fontSize: 16.sp, // Use ScreenUtil for font size
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Send(), // Add your HistoryScreen widget
                                  ),
                                );
                              },
                              child: Text(
                                'See All',
                                style: TextStyle(
                                  fontSize: 16.sp, // Use ScreenUtil for font size
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h), // Use ScreenUtil for height
                       CreditHistory(title: 'PayPal', amount: '5000', date: '12:20 AM', subtitle: 'Successful', icon:Icon(Icons.paypal)),
                        CreditHistory(title: 'Netflix', amount: '500', date: '1:30 AM', subtitle: 'Debit', icon:Icon(Icons.payment)),
                         DebitHistory(title: 'Spotify', amount: '100', date: '3:02 AM', subtitle: 'Debit', icon:Icon(Icons.music_note))
                      ],
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

  void _showEditProfileDialog(BuildContext context) {
    TextEditingController usernameController = TextEditingController(text: firstName);
    TextEditingController emailController = TextEditingController(text: email);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: buttonColor,
          title: Row(
            children: [
              Icon(Icons.edit, color: buttonColor, size: 20),
              const SizedBox(width: 5),
              const Text(
                'Edit Profile',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                style: TextStyle(color: Colors.black87),
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: 'Username',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                style: TextStyle(color: Colors.black87),
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(), // Cancel
                  child: const Text('Cancel', style: TextStyle(color: Colors.white),),
                ),
                TextButton(
  onPressed: () async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
        'username': usernameController.text,
        'email': emailController.text,
      });
      Navigator.of(context).pop(); // Close dialog
    } catch (e) {
      print("Error updating user: $e"); // Log the error
      // Optionally, show a message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update profile")),
      );
    }
  },
  child: const Text('Save Changes', style: TextStyle(color: Colors.white),),
)

              ],
            ),
          ],
        );
      },
    );
  }


}
