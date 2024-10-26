import 'package:chimeup/Screens/Home.dart';
import 'package:chimeup/Screens/signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chimeup/Resources/auth_methods.dart';
import '../Utils/colors.dart';
import 'newPassword.dart';
import 'wallets.dart';

class ProfilePage extends StatefulWidget {
  final String userName; 
  final String email;

  const ProfilePage({super.key, required this.userName, required this.email}); 

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    String firstLetter = widget.userName.isNotEmpty ? widget.userName[0].toUpperCase() : 'A';

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF192038),
              Color(0xFF0F1523),
            ],
          ),
        ),
        child: Column(
          children: [
            // Profile Header Section
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blueAccent,
                    child: Text(
                      firstLetter,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.userName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.email,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Profile Menu Options
            Expanded(
              child: ListView(
                children: [
                  _buildProfileOption(
                    context,
                    Icons.settings_outlined,
                    'Edit Profile',
                    () => _showEditProfileDialog(context), // Use proper callback
                  ),
                  _buildProfileOption(
                    context,
                    Icons.wallet_outlined,
                    'Wallets',
                    () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Rate())),
                  ),
                  _buildProfileOption(
                    context,
                    Icons.lock_outline_rounded,
                    'Change Password',
                    () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const NewPassword())), // Replace with the correct page
                  ),
                  _buildProfileOption(
                    context,
                    Icons.help,
                    'Help & Support',
                    () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomePage())), // Replace with the correct page
                  ),
                  _buildProfileOption(
                    context,
                    Icons.logout,
                    'Log Out',
                    null,
                    isLogout: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(
      BuildContext context, IconData icon, String title, Function()? onTap,
      {bool isLogout = false}) {
    return ListTile(
      leading: Icon(
        icon,
        color: isLogout ? Colors.redAccent : Colors.white,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          color: isLogout ? Colors.redAccent : Colors.white,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
      onTap: () async {
        if (isLogout) {
          await Auth().signOut(); 
          if (context.mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const SigninScreen()),
            );
          }
        } else if (onTap != null) {
          onTap(); // Call the passed function
        }
      },
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    TextEditingController usernameController = TextEditingController(text: widget.userName);
    TextEditingController emailController = TextEditingController(text: widget.email);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.edit, color: buttonColor, size: 20),
              const SizedBox(width: 5),
              const Text(
                'Edit Profile',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
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
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
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
                  child: const Text('Cancel'),
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
        const SnackBar(content: Text("Failed to update profile")),
      );
    }
  },
  child: const Text('Save Changes'),
)

              ],
            ),
          ],
        );
      },
    );
  }
}
