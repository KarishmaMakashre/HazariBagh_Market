import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../colors/AppColors.dart';
import '../provider/profile_provider.dart';
import '../provider/theme_provider.dart';
import '../provider/auth_provider.dart';
import '../widgets/top_header.dart';
import 'Auth/login_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ProfileProvider>().fetchProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeProvider = context.watch<ThemeProvider>();
    final profileProvider = context.watch<ProfileProvider>();
    final user = profileProvider.user;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: profileProvider.loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          const TopHeader(),

          /// 🔙 BACK
          Padding(
            padding:
            EdgeInsets.symmetric(horizontal: w * 0.04, vertical: 10),
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Row(
                children: [
                  const Icon(Icons.arrow_back_ios),
                  const SizedBox(width: 6),
                  Text(
                    "Back",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: w * 0.06),
              child: Column(
                children: [
                  SizedBox(height: h * 0.02),

                  /// 👤 PROFILE CARD
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: w * 0.14,
                          backgroundColor: Colors.grey.shade300,
                          child: CircleAvatar(
                            radius: w * 0.135,
                            backgroundImage: user?.profile != null
                                ? NetworkImage(user!.profile!)
                                : const AssetImage(
                                "assets/images/girl.jpg")
                            as ImageProvider,
                          ),
                        ),

                        const SizedBox(height: 12),

                        /// 🧑 NAME
                        Text(
                          user?.name ?? "User",
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 4),

                        /// 📞 PHONE
                        Text(
                          user?.phone ?? "Not available",
                          style:
                          const TextStyle(color: Colors.grey),
                        ),

                        const SizedBox(height: 6),

                        /// 🚻 GENDER
                        Text(
                          "Gender: ${user?.gender ?? "-"}",
                          style: const TextStyle(
                              color: Colors.black54),
                        ),

                        const SizedBox(height: 4),

                        /// 🎂 DOB
                        Text(
                          "DOB: ${user?.dob != null ? user!.dob!.split("T").first : "-"}",
                          style: const TextStyle(
                              color: Colors.black54),
                        ),

                        const SizedBox(height: 14),

                        /// ✏ EDIT PROFILE
                        OutlinedButton.icon(
                          icon: const Icon(Icons.edit),
                          label: const Text("Edit Profile"),
                          onPressed: () async {
                            final updated =
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                const EditProfileScreen(),
                              ),
                            );

                            /// 🔄 REFRESH AFTER RETURN
                            if (updated == true && mounted) {
                              context
                                  .read<ProfileProvider>()
                                  .fetchProfile();
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// 🌗 DARK MODE
                  _menuTile(
                    icon: Icons.dark_mode,
                    iconColor:
                    isDark ? Colors.amber : Colors.black,
                    title: "Dark Mode",
                    trailing: Switch.adaptive(
                      value: themeProvider.isDarkMode,
                      onChanged: themeProvider.toggleTheme,
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// ⚙ SETTINGS
                  _settingsTile(Icons.language, "Language"),
                  _settingsTile(Icons.settings, "Setting"),
                  _settingsTile(Icons.info_outline, "About"),
                  _settingsTile(Icons.description_outlined,
                      "Terms & Conditions"),
                  _settingsTile(Icons.privacy_tip_outlined,
                      "Privacy Policy"),
                  _settingsTile(Icons.star_border, "Rate This App"),
                  _settingsTile(Icons.share, "Share This App"),

                  const SizedBox(height: 30),

                  /// 🚪 LOGOUT
                  _actionButton(
                    icon: Icons.logout,
                    title: "Logout",
                    color: Colors.red,
                    onTap: () {
                      context.read<AuthProvider>().logout();
                      context
                          .read<ProfileProvider>()
                          .clearProfile();

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                            const LoginScreen()),
                            (_) => false,
                      );
                    },
                  ),

                  const SizedBox(height: 14),

                  /// 🗑 DELETE ACCOUNT
                  _actionButton(
                    icon: Icons.delete,
                    title: "Delete Account",
                    color: Colors.red,
                    onTap: () =>
                        _confirmDeleteAccount(context),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ⚠ DELETE CONFIRMATION
  void _confirmDeleteAccount(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Account"),
        content:
        const Text("Are you sure? This action cannot be undone."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red),
            onPressed: () async {
              Navigator.pop(context);
              final success = await context
                  .read<ProfileProvider>()
                  .deleteAccount();

              if (success && context.mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const LoginScreen()),
                      (_) => false,
                );
              }
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  /// 🌗 MENU TILE
  Widget _menuTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    Widget? trailing,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.15),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(title),
        trailing: trailing,
      ),
    );
  }

  /// ⚙ SETTINGS TILE
  Widget _settingsTile(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.grey.shade700),
        title: Text(title,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w500)),
        trailing:
        const Icon(Icons.arrow_forward_ios, size: 14),
      ),
    );
  }

  /// 🔴 ACTION BUTTON
  Widget _actionButton({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: TextButton.icon(
        icon: Icon(icon, color: color),
        label: Text(
          title,
          style:
          TextStyle(color: color, fontWeight: FontWeight.w600),
        ),
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: onTap,
      ),
    );
  }
}
