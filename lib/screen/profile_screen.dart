import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/screen/Auth/login_screen.dart';
import '../../widgets/top_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        children: [
          /// 🔵 TOP HEADER
          const TopHeader(),

          /// 🔙 BACK BUTTON
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 12, bottom: 8),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    // decoration: BoxDecoration(
                    //   // color: Colors.white,          // ✅ White BG
                    //   borderRadius: BorderRadius.circular(10),
                    //   boxShadow: [
                    //     BoxShadow(
                    //       color: Colors.black.withOpacity(0.08),
                    //       blurRadius: 6,
                    //       offset: const Offset(0, 3),
                    //     ),
                    //   ],
                    // ),
                    child: Row(
                      children: const [
                        Icon(Icons.arrow_back, size: 20, color: Colors.black87),
                        SizedBox(width: 6),
                        Text(
                          "Back",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// MAIN BODY
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                color: Colors.white,                // ✅ White Body

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile Image
                    CircleAvatar(
                      radius: 45,
                      backgroundImage: AssetImage("assets/images/girl.png"),
                    ),
                    const SizedBox(height: 12),

                    // Name
                    const Text(
                      "Jonathan Patterson",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 4),
                    const Text(
                      "hello@reallygreatsite.com",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),

                    const SizedBox(height: 25),

                    profileTile(
                      icon: Icons.edit,
                      title: "Edit Profile",
                      onTap: () {},
                      iconColor: Colors.green,
                    ),

                    const SizedBox(height: 10),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "General Settings",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Mode Switch
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.black87,
                            child: const Icon(Icons.dark_mode, color: Colors.white, size: 16),
                          ),
                          const SizedBox(width: 12),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Mode", style: TextStyle(fontSize: 14)),
                              Text(
                                "Dark & Light",
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Switch(value: true, onChanged: (v) {}),
                        ],
                      ),
                    ),

                    profileTile(icon: Icons.language, title: "Language", onTap: () {}, iconColor: Colors.amber),
                    profileTile(icon: Icons.settings, title: "Setting", onTap: () {}, iconColor: Colors.grey),
                    profileTile(icon: Icons.info_outline, title: "About", onTap: () {}, iconColor: Colors.purple),
                    profileTile(icon: Icons.description, title: "Terms & Conditions", onTap: () {}, iconColor: Colors.blue),
                    profileTile(icon: Icons.privacy_tip, title: "Privacy Policy", onTap: () {}, iconColor: Colors.red),
                    profileTile(icon: Icons.star_rate, title: "Rate This App", onTap: () {}, iconColor: Colors.deepPurple),
                    profileTile(icon: Icons.share, title: "Share This App", onTap: () {}, iconColor: Colors.pink),

                    const SizedBox(height: 20),

                    /// LOGOUT
                    InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                              (route) => false,
                        );
                      },
                      child: Container(
                        width: mq.width * 0.8,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey.shade100,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.logout, color: Colors.red),
                            SizedBox(width: 8),
                            Text(
                              "Logout",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Reusable Tile
  Widget profileTile({
    required IconData icon,
    required String title,
    required Function() onTap,
    required Color iconColor,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 14,
        backgroundColor: iconColor.withOpacity(0.2),
        child: Icon(icon, color: iconColor, size: 16),
      ),
      title: Text(title, style: const TextStyle(fontSize: 14)),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
