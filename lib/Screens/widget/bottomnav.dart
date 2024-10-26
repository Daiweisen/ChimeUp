import 'package:chimeup/Screens/Home.dart';
import 'package:chimeup/Utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '../profile_page.dart';
import '../wallets.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  _BottomnavState createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  
  String username = '';
  String email = '';
  int _selectedIndex = 0; // To keep track of the selected page

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
        _pages[2] = ProfilePage(userName: username, email: email);
      });
    }
  }

  // List of pages to navigate between
  final List<Widget> _pages = [
    const HomePage(),
    const Rate(),
    const Placeholder(), // Temporary placeholder until username is fetched
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: _pages, // Display the selected page
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF0F1523),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_exchange_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex, // Highlight the selected item
        selectedItemColor: buttonColor, // Color for the selected item
        unselectedItemColor: Colors.grey, // Color for unselected items
        onTap: _onItemTapped, // Handle item tap
      ),
    );
  }
}

// First page
class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Home Page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

// Second page
class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Search Page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

// Third page
class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Profile Page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
