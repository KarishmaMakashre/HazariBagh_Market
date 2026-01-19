import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../colors/AppColors.dart';
import '../../l10n/app_localizations.dart';
import '../provider/bottom_nav_provider.dart';

class UserBottomNav extends StatelessWidget {
  const UserBottomNav({super.key});

  // 🎨 COLORS
  static const Color lightBg = Color(0xFFFFD68A); // light center
  static const Color darkBorder = Color(0xFFB8892E); // dark border
  static const Color darkIcon = Color(0xFF3A2A00); // dark icon/text

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<BottomNavProvider>();
    final loc = AppLocalizations.of(context)!;

    return Container(
      height: 74,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _item(context, Icons.home, loc.navHome, 0),
          _item(context, Icons.list_alt, loc.navCategories, 1),
          _item(context, Icons.inventory_2, loc.navOrders, 2),
          _item(context, Icons.headset_mic, loc.navSupport, 3),
        ],
      ),
    );
  }

  Widget _item(
      BuildContext context,
      IconData icon,
      String label,
      int index,
      ) {
    final nav = context.watch<BottomNavProvider>();
    final isActive = nav.currentIndex == index;

    return GestureDetector(
      onTap: () => context.read<BottomNavProvider>().changeIndex(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? lightBg : Colors.transparent, // 🟡 center light
              border: isActive
                  ? Border.all(
                color: darkBorder, // 🔲 border dark
                width: 2,
              )
                  : null,
            ),
            child: Icon(
              icon,
              size: 22,
              color: isActive ? Colors.white : Colors.black87, // ⚫ icon dark
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isActive ? darkIcon : Colors.black87, // ⚫ text dark
            ),
          ),
        ],
      ),
    );
  }
}
