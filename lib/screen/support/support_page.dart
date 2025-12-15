import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/screen/support/raise_complaint_screen.dart';
import 'package:hazari_bagh_market/widgets/top_header.dart';
import 'contact_us_screen.dart';
import 'faq_screen.dart';
import 'live_chat_screen.dart';

class SupportPage extends StatefulWidget {
  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  int selectedIndex = 0; 

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final w = mq.width;
    final h = mq.height;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TopHeader(),
          SizedBox(height: h * 0.015),

          /// ---------- TABS (SCROLLABLE) ----------
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(width: 10),
                tabButton("Contact Us", 0, w, h),
                SizedBox(width: 10),
                tabButton("Live Chat", 1, w, h),
                SizedBox(width: 10),
                tabButton("FAQs", 2, w, h),
                SizedBox(width: 10),
                tabButton("Raise Complaint", 3, w, h),
                SizedBox(width: 10),
              ],
            ),
          ),

          SizedBox(height: h * 0.020),

          /// ---------- MAIN PAGE CONTENT ----------
          Expanded(
            child: IndexedStack(
              index: selectedIndex,
              children: [
                ContactUsScreen(),
                LiveChatScreen(),
                FaqScreenUpdated(),
                RaiseComplaintScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ---------- TAB BUTTON ----------
  Widget tabButton(String title, int index, double w, double h) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: w * 0.04,
          vertical: h * 0.012,
        ),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(w * 0.02),

          /// Shadow only for unselected button
          boxShadow: isSelected
              ? []
              : [
            BoxShadow(
              color: Colors.black12,
              blurRadius: w * 0.02,
              offset: Offset(0, h * 0.003),
            ),
          ],
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: w * 0.035,
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
