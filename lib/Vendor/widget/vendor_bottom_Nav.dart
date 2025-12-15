import 'package:flutter/material.dart';

class VendorBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  const VendorBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTabTapped,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea( // 🔑 ensures it sticks to bottom safely
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF3B73A8),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(14)
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.dashboard, "Dashboard", 0),
            _navItem(Icons.inventory_2, "Products", 1),
            _navItem(Icons.shopping_cart, "Orders", 2),
            _navItem(Icons.analytics, "Analytics", 3),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTabTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 26,
            color: isSelected ? Colors.white : Colors.white70,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
