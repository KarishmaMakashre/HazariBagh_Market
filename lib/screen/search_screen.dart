import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/screen/home/home_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
      
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      
            const SizedBox(height: 20),
      
      
            /// 🔍 BEAUTIFUL SEARCH BAR
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.04,
                vertical: width * 0.02,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04,
                  vertical: width * 0.018,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search_rounded,
                      color: Colors.grey.shade600,
                      size: 26,
                    ),
                    const SizedBox(width: 10),
      
                    Expanded(
                      child: TextField(
                        cursorColor: Colors.blue,
                        decoration: InputDecoration(
                          hintText: "Search stores, products...",
                          hintStyle: TextStyle(
                            fontSize: 15,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
      
                    Icon(
                      Icons.mic_none_rounded,
                      color: Colors.grey.shade600,
                      size: 22,
                    ),
                  ],
                ),
              ),
            ),
      
            const SizedBox(height: 20),
      
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  );
                },
                child: Row(
                  children: [
                    const Icon(Icons.arrow_back, size: 20),
                    const SizedBox(width: 6),
                    const Text(
                      "Back",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
      
            /// ---------------- Recent Searches ----------------
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: const Text(
                "Recent Searches",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
      
            const SizedBox(height: 12),
      
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _recentChip("Grocery"),
                  _recentChip("Mobile Shop"),
                  _recentChip("Milk Store"),
                  _recentChip("Fashion Store"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔵 Recent Search Chip
  Widget _recentChip(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.white,
      elevation: 2,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
