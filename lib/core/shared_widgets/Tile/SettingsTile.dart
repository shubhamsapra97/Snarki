import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData leading;
  final String title;
  final String subtitle;

  SettingsTile({
    Key? key,
    required this.leading,
    required this.onPressed,
    required this.title,
    required this.subtitle
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              leading,
              color: Color(0xFF757575),
            ),
            SizedBox(
              width: 30
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(subtitle)
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}