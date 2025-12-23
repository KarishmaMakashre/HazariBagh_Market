import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hazari_bagh_market/screen/Auth/login_screen.dart';
import '../../widgets/top_header.dart';
import '../../provider/theme_provider.dart';
import '../../provider/language_provider.dart';
import '../../l10n/app_localizations.dart';
import '../colors/AppColors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = theme.brightness == Brightness.dark;

    // 🌗 THEME BASED COLORS
    final bgColor = isDark ? AppColors.bgDark : AppColors.bgLight;
    final tileBgColor =
    isDark ? const Color(0xFF2A2A2A) : AppColors.white;
    final iconBgColor =
    isDark ? Colors.grey.shade800 : Colors.grey.shade200;

    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          const TopHeader(),

          /// 🔙 BACK
          Padding(
            padding: EdgeInsets.only(
              left: w * 0.04,
              top: h * 0.015,
              bottom: h * 0.01,
            ),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back,
                    size: w * 0.055,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: w * 0.015),
                  Text(
                    t.back,
                    style: TextStyle(
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.w600,
                      color: theme.textTheme.bodyLarge!.color,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: w * 0.05,
                vertical: h * 0.025,
              ),
              child: Column(
                children: [
                  /// 👤 PROFILE IMAGE
                  CircleAvatar(
                    radius: w * 0.12,
                    backgroundColor: iconBgColor,
                    child: CircleAvatar(
                      radius: w * 0.115,
                      backgroundImage:
                      const AssetImage("assets/images/girl.jpg"),
                    ),
                  ),

                  SizedBox(height: h * 0.015),

                  /// 👤 NAME
                  Text(
                    "Jonathan Patterson",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: w * 0.05,
                      color: theme.textTheme.bodyLarge!.color,
                    ),
                  ),

                  SizedBox(height: h * 0.005),

                  /// ✉ EMAIL
                  Text(
                    "hello@reallygreatsite.com",
                    style: TextStyle(
                      fontSize: w * 0.035,
                      color: theme.textTheme.bodySmall!.color,
                    ),
                  ),

                  SizedBox(height: h * 0.035),

                  /// ✏ EDIT PROFILE
                  _profileTile(
                    context: context,
                    w: w,
                    icon: Icons.edit,
                    title: t.editProfile,
                    iconColor: AppColors.success,
                    tileBgColor: tileBgColor,
                    onTap: () {},
                  ),

                  SizedBox(height: h * 0.03),

                  /// ⚙ GENERAL SETTINGS
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      t.generalSettings,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: w * 0.045,
                        color: theme.textTheme.bodyLarge!.color,
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.015),

                  /// 🌗 DARK / LIGHT MODE
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: h * 0.015,
                      horizontal: w * 0.04,
                    ),
                    decoration: BoxDecoration(
                      color: tileBgColor,
                      borderRadius: BorderRadius.circular(w * 0.03),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadow,
                          blurRadius: 4,
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: w * 0.04,
                          backgroundColor: AppColors.primary,
                          child: Icon(
                            isDark
                                ? Icons.dark_mode
                                : Icons.light_mode,
                            color: AppColors.white,
                            size: w * 0.04,
                          ),
                        ),
                        SizedBox(width: w * 0.03),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t.mode,
                              style: TextStyle(
                                fontSize: w * 0.038,
                                fontWeight: FontWeight.w600,
                                color:
                                theme.textTheme.bodyLarge!.color,
                              ),
                            ),
                            Text(
                              t.darkLight,
                              style: TextStyle(
                                fontSize: w * 0.03,
                                color:
                                theme.textTheme.bodySmall!.color,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Switch.adaptive(
                          activeColor: AppColors.primary,
                          value: themeProvider.themeMode ==
                              ThemeMode.dark,
                          onChanged:
                          themeProvider.toggleTheme,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: h * 0.02),

                  /// 🌍 LANGUAGE
                  _profileTile(
                    context: context,
                    w: w,
                    icon: Icons.language,
                    title: t.language,
                    iconColor: AppColors.warning,
                    tileBgColor: tileBgColor,
                    onTap: () => _showLanguageDialog(context),
                  ),

                  _profileTile(
                    context: context,
                    w: w,
                    icon: Icons.settings,
                    title: t.settings,
                    iconColor: AppColors.textGrey,
                    tileBgColor: tileBgColor,
                    onTap: () {},
                  ),

                  _profileTile(
                    context: context,
                    w: w,
                    icon: Icons.info_outline,
                    title: t.about,
                    iconColor: AppColors.primaryLight,
                    tileBgColor: tileBgColor,
                    onTap: () {},
                  ),

                  _profileTile(
                    context: context,
                    w: w,
                    icon: Icons.description,
                    title: t.terms,
                    iconColor: AppColors.primaryDark,
                    tileBgColor: tileBgColor,
                    onTap: () {},
                  ),

                  _profileTile(
                    context: context,
                    w: w,
                    icon: Icons.privacy_tip,
                    title: t.privacy,
                    iconColor: AppColors.error,
                    tileBgColor: tileBgColor,
                    onTap: () {},
                  ),

                  SizedBox(height: h * 0.03),

                  /// 🚪 LOGOUT
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginScreen(),
                        ),
                            (route) => false,
                      );
                    },
                    child: Container(
                      width: w * 0.8,
                      padding:
                      EdgeInsets.symmetric(vertical: h * 0.015),
                      decoration: BoxDecoration(
                        color: tileBgColor,
                        borderRadius:
                        BorderRadius.circular(w * 0.08),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout,
                              color: AppColors.error,
                              size: w * 0.05),
                          SizedBox(width: w * 0.02),
                          Text(
                            t.logout,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: w * 0.04,
                              color: AppColors.error,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🌍 LANGUAGE DIALOG
  void _showLanguageDialog(BuildContext context) {
    final langProvider = context.read<LanguageProvider>();
    final t = AppLocalizations.of(context)!;
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor:
        isDark ? AppColors.bgDark : AppColors.white,
        title: Text(t.selectLanguage),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("English"),
              onTap: () {
                langProvider.changeLanguage(
                    const Locale('en'));
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("हिन्दी"),
              onTap: () {
                langProvider.changeLanguage(
                    const Locale('hi'));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  /// ♻ REUSABLE TILE
  Widget _profileTile({
    required BuildContext context,
    required double w,
    required IconData icon,
    required String title,
    required Color iconColor,
    required Color tileBgColor,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.symmetric(vertical: w * 0.01),
      decoration: BoxDecoration(
        color: tileBgColor,
        borderRadius: BorderRadius.circular(w * 0.03),
      ),
      child: ListTile(
        contentPadding:
        EdgeInsets.symmetric(horizontal: w * 0.04),
        leading: CircleAvatar(
          radius: w * 0.04,
          backgroundColor: iconColor.withOpacity(0.2),
          child:
          Icon(icon, color: iconColor, size: w * 0.04),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: w * 0.038,
            color: theme.textTheme.bodyLarge!.color,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: theme.textTheme.bodySmall!.color,
        ),
        onTap: onTap,
      ),
    );
  }
}
