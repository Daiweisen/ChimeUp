import 'package:chimeup/Screens/Home.dart';
import 'package:chimeup/Screens/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Screens/wallets.dart';

const webScreenSize = 600;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: homeScreenItems.isNotEmpty
          ? homeScreenItems[_selectedIndex] // Display the selected page
          : const Center(child: CircularProgressIndicator()), // Show loading indicator
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.monetization_on), label: 'Rate'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex, // Current selected index
        onTap: onItemTapped, // Handle item tap
      ),
    );
  }
}
