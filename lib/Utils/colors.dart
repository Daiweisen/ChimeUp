import 'dart:ui';

import 'package:flutter/rendering.dart';

Color buttonColor = const Color(0xFF1E63FE);
Color white = const Color(0xFFFFFFFF);
Color primaryColor = buttonColor;
Color secondaryColor = const Color.fromARGB(255, 117, 117, 119);

// Define the gradient separately
LinearGradient bg = const LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFF192038), // Navy blue shade
    Color(0xFF0F1523), // Darker shade
  ],
);
