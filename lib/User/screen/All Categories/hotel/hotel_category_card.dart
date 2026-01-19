import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Model/hotel_category_model.dart';
import '../../../../colors/AppColors.dart';
import '../../../../l10n/app_localizations.dart';
import 'hotel_product_list_screen.dart';

class HotelCategoryCard extends StatelessWidget {
  final HotelCategoryModel category;
  final double width;

  const HotelCategoryCard({
    super.key,
    required this.category,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardColor =
    isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor =
    isDark ? Colors.white : Colors.black87;
    final borderColor =
    isDark ? Colors.white10 : Colors.transparent;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HotelProductListScreen(
              /// 🔑 ALWAYS ENGLISH KEY
              categoryTitle: category.title,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(14),

          /// 🌙 DARK = BORDER | ☀️ LIGHT = SHADOW
          boxShadow: isDark
              ? []
              : const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
          border: Border.all(color: borderColor),
        ),
        child: Column(
          children: [
            /// 🖼 IMAGE
            Expanded(
              flex: 7,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(14),
                ),
                child: Image.asset(
                  category.image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            /// 📛 TITLE
            Expanded(
              flex: 3,
              child: Center(
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    loc.getByKey(category.title),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: width * 0.032,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                ),
              ),
            ),

            /// 🔴 ACCENT LINE (OPTIONAL – PREMIUM LOOK)
            Container(
              height: 3,
              decoration: BoxDecoration(
                // color: AppColors.primary,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
