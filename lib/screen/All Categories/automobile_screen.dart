import 'package:flutter/material.dart';

class AutomobileScreen extends StatefulWidget {
  const AutomobileScreen({super.key});

  @override
  State<AutomobileScreen> createState() => _AutomobileScreenState();
}

class _AutomobileScreenState extends State<AutomobileScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // 🖼 SMALL IMAGE
            Image.asset(
              "assets/images/not_found.jpg",
              width: size.width * 0.40,   // 40% of screen width
              height: size.width * 0.40,  // Keep square shape
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 12),

            // Optional text
            const Text(
              "No Data Found",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
