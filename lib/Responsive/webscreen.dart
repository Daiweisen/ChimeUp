import 'package:chimeup/Screens/Home.dart';
import 'package:chimeup/Screens/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Screens/wallets.dart';
import '../Utils/colors.dart';

const webScreenSize = 600;

class Webscreen extends StatefulWidget {
  const Webscreen({super.key});

  @override
  _WebScreenState createState() => _WebScreenState();
}

class _WebScreenState extends State<Webscreen> {
  String username = '';
  String email = '';
  int _selectedIndex = 0; // To keep track of the selected page
  List<Widget> homeScreenItems = []; // Initialize as empty list

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      setState(() {
        username = userSnapshot['username'] ?? ''; // Fetch username from Firestore
        email = userSnapshot['email'] ?? ''; // Use the current user's email

        // Rebuild the pages with the updated username
        homeScreenItems = [
          const HomePage(),
          const Rate(),
          ProfilePage(userName: username, email: email),
        ];
      });
    }
  }

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF192038), 
        
        actions: [
          const SizedBox(width: 16), // Add space between icons
          IconButton(
            icon: Icon(
              Icons.home,
              color: _selectedIndex == 0 ? buttonColor : Colors.grey,
            ),
            onPressed: () => onItemTapped(0), // Home
          ),
          const SizedBox(width: 16), // Add space between icons
          IconButton(
            icon: Icon(
              Icons.currency_exchange_outlined,
              color: _selectedIndex == 1 ? buttonColor : Colors.grey,
            ),
            onPressed: () => onItemTapped(1), // Rate
          ),
          const SizedBox(width: 16), // Add space between icons
          IconButton(
            icon: Icon(
              Icons.person_outline_outlined,
              color: _selectedIndex == 2 ? buttonColor : Colors.grey,
            ),
            onPressed: () => onItemTapped(2), // Profile
          ),
        ],
      ),
      body: homeScreenItems.isNotEmpty
          ? homeScreenItems[_selectedIndex] // Display the selected page
          : const Center(child: CircularProgressIndicator()), // Show loading indicator
    );
  }
}
