import 'package:chimeup/Responsive/webscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/userProvider.dart';

class ResponsiveLayouts extends StatefulWidget {
  final Widget mobileScreenLayout;
  final Widget webScreenLayout;

  const ResponsiveLayouts({
    super.key,
    required this.mobileScreenLayout,
    required this.webScreenLayout,
  });

  @override
  State<ResponsiveLayouts> createState() => _ResponsiveLayoutsState();
}

class _ResponsiveLayoutsState extends State<ResponsiveLayouts> {
  bool _isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    addData();
  }

  Future<void> addData() async {
    try {
      UserProvider userProvider =
          Provider.of<UserProvider>(context, listen: false);
      await userProvider.fetchUserData();
    } catch (e) {
      // Handle any errors here
      print("Error fetching user data: $e");
    } finally {
      // Ensure loading state is updated
      setState(() {
        _isLoading = false; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading // Show a loading indicator while fetching data
        ? const Center(child: CircularProgressIndicator())
        : LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > webScreenSize) {
                // Switch to web layout for larger screens
                return widget.webScreenLayout;
              }
              // Switch to mobile layout for smaller screens
              return widget.mobileScreenLayout;
            },
          );
  }
}
