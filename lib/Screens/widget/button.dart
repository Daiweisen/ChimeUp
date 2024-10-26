import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final bool isLoading;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.child,
    required this.color,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return ElevatedButton(
     style: ElevatedButton.styleFrom(
        backgroundColor: color,
         fixedSize: Size(screenSize.width * 0.50, 60),
        elevation: 10, // Added shadow effect
        shadowColor: const Color.fromARGB(255, 38, 37, 37),
      ),
      onPressed: onPressed,
      child: !isLoading
          ? child
          : const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ),
            ),
    );
  }
}



class CustomButton2 extends StatelessWidget {
  final Widget child;
  final Color color;
  final bool isLoading;
  final VoidCallback onPressed;

  const CustomButton2({
    super.key,
    required this.child,
    required this.color,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return ElevatedButton(
     style: ElevatedButton.styleFrom(
        backgroundColor: color,
         fixedSize: Size(screenSize.width * 0.32, 40),
        elevation: 10, // Added shadow effect
        shadowColor: const Color.fromARGB(255, 38, 37, 37),
      ),
      onPressed: onPressed,
      child: !isLoading
          ? child
          : const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ),
            ),
    );
  }
}