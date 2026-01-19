import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  final double width;
  final Color color;
  final String text;
  final VoidCallback? onTap;

  const AppBackButton({
    super.key,
    required this.width,
    required this.color,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      child: Align(
        alignment: Alignment.centerLeft,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap ?? () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min, // ⭐ important
              children: [
                Icon(
                  Icons.arrow_back_ios_new,
                  color: color,
                  size: width * 0.045,
                ),
                SizedBox(width: width * 0.02),
                Text(
                  text,
                  style: TextStyle(
                    color: color,
                    fontSize: width * 0.042,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
