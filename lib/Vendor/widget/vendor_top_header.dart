import 'package:flutter/material.dart';
import '../vendor Screens/vendor_notification_screen.dart';
import '../vendor Screens/vendor_profile_screen.dart';

class VendorTopHeader extends StatelessWidget
    implements PreferredSizeWidget {
  const VendorTopHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: primary,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      automaticallyImplyLeading: false,

      title: Image.asset(
        'assets/images/HazariBaghLogo.jpeg',
        height: 32,
      ),

      actions: [
        IconButton(
          icon: const Icon(
            Icons.notifications_none,
            color: Colors.white,
          ),
          onPressed: () {
            // Navigate to notification screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const VendorNotificationScreen(),
              ),
            );
          },
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(
            Icons.person,
            color: Colors.white,
          ),
          onPressed: () {
            // Navigate to profile screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const VendorProfileScreen(),
              ),
            );
          },
        ),
        const SizedBox(width: 2),

      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
