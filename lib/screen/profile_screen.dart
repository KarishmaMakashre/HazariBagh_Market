import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/screen/Auth/login_screen.dart';
import '../../widgets/top_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          /// 🔵 TOP HEADER
          const TopHeader(),

          /// 🔙 BACK BUTTON
          Padding(
            padding: EdgeInsets.only(
              left: w * 0.04,
              top: h * 0.015,
              bottom: h * 0.01,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back,
                        size: w * 0.055,
                        color: Colors.black87,
                      ),
                      SizedBox(width: w * 0.015),
                      Text(
                        "Back",
                        style: TextStyle(
                          fontSize: w * 0.04,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// 🔽 MAIN BODY
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: w * 0.05,
                  vertical: h * 0.025,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// 👤 PROFILE IMAGE
                    CircleAvatar(
                      radius: w * 0.12,
                      backgroundImage:
                      const AssetImage("assets/images/girl.png"),
                    ),

                    SizedBox(height: h * 0.015),

                    /// 👤 NAME
                    Text(
                      "Jonathan Patterson",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: w * 0.05,
                      ),
                    ),

                    SizedBox(height: h * 0.005),

                    /// ✉ EMAIL
                    Text(
                      "hello@reallygreatsite.com",
                      style: TextStyle(
                        fontSize: w * 0.035,
                        color: Colors.black54,
                      ),
                    ),

                    SizedBox(height: h * 0.035),

                    /// ✏ EDIT PROFILE
                    profileTile(
                      w: w,
                      icon: Icons.edit,
                      title: "Edit Profile",
                      iconColor: Colors.green,
                      onTap: () {},
                    ),

                    SizedBox(height: h * 0.02),

                    /// ⚙ GENERAL SETTINGS
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "General Settings",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: w * 0.045,
                        ),
                      ),
                    ),

                    SizedBox(height: h * 0.015),

                    /// 🌗 MODE SWITCH
                    Container(
                      padding: EdgeInsets.symmetric(vertical: h * 0.015),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: w * 0.04,
                            backgroundColor: Colors.black87,
                            child: Icon(
                              Icons.dark_mode,
                              color: Colors.white,
                              size: w * 0.04,
                            ),
                          ),
                          SizedBox(width: w * 0.03),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Mode",
                                style: TextStyle(fontSize: w * 0.038),
                              ),
                              Text(
                                "Dark & Light",
                                style: TextStyle(
                                  fontSize: w * 0.03,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Switch(value: true, onChanged: (v) {}),
                        ],
                      ),
                    ),

                    profileTile(
                        w: w,
                        icon: Icons.language,
                        title: "Language",
                        iconColor: Colors.amber,
                        onTap: () {}),
                    profileTile(
                        w: w,
                        icon: Icons.settings,
                        title: "Settings",
                        iconColor: Colors.grey,
                        onTap: () {}),
                    profileTile(
                        w: w,
                        icon: Icons.info_outline,
                        title: "About",
                        iconColor: Colors.purple,
                        onTap: () {}),
                    profileTile(
                        w: w,
                        icon: Icons.description,
                        title: "Terms & Conditions",
                        iconColor: Colors.blue,
                        onTap: () {}),
                    profileTile(
                        w: w,
                        icon: Icons.privacy_tip,
                        title: "Privacy Policy",
                        iconColor: Colors.red,
                        onTap: () {}),
                    profileTile(
                        w: w,
                        icon: Icons.star_rate,
                        title: "Rate This App",
                        iconColor: Colors.deepPurple,
                        onTap: () {}),
                    profileTile(
                        w: w,
                        icon: Icons.share,
                        title: "Share This App",
                        iconColor: Colors.pink,
                        onTap: () {}),

                    SizedBox(height: h * 0.03),

                    /// 🚪 LOGOUT BUTTON
                    InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LoginScreen()),
                              (route) => false,
                        );
                      },
                      child: Container(
                        width: w * 0.8,
                        padding:
                        EdgeInsets.symmetric(vertical: h * 0.015),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(w * 0.08),
                          color: Colors.grey.shade100,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.logout,
                                color: Colors.red, size: w * 0.05),
                            SizedBox(width: w * 0.02),
                            Text(
                              "Logout",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: w * 0.04,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: h * 0.05),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ♻ REUSABLE PROFILE TILE
  Widget profileTile({
    required double w,
    required IconData icon,
    required String title,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: w * 0.04,
        backgroundColor: iconColor.withOpacity(0.2),
        child: Icon(icon, color: iconColor, size: w * 0.04),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: w * 0.038),
      ),
      trailing: Icon(Icons.chevron_right, size: w * 0.05),
      onTap: onTap,
    );
  }
}
