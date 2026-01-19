import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Model/product_model.dart';
import '../../../../colors/AppColors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../provider/hotel_provider.dart';
import '../../../provider/cart_provider.dart';
import '../../../widgets/app_back_button.dart';
import '../../../widgets/top_header.dart';

class HotelProductListScreen extends StatelessWidget {
  /// 🔑 ALWAYS ENGLISH KEY
  final String categoryTitle;

  const HotelProductListScreen({
    super.key,
    required this.categoryTitle,
  });

  @override
  Widget build(BuildContext context) {
    final hotelProvider = context.watch<HotelProvider>();
    final loc = AppLocalizations.of(context)!;

    final products =
    hotelProvider.getProductsByCategory(categoryTitle);

    final w = MediaQuery.of(context).size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor =
    isDark ? const Color(0xFF0F172A) : const Color(0xFFF5F7FA);
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor =
    isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    final cardColor =
    isDark ? const Color(0xFF1E293B) : Colors.white;

    return Scaffold(
      backgroundColor: Color(0xffF6F6F6FF),
      body: Column(
        children: [
          /// 🔝 TOP HEADER
          const TopHeader(),

          /// 🔙 BACK BUTTON
          AppBackButton(
            width: w,
            color: AppColors.primary,
            text: loc.back,
          ),

          /// 📦 PRODUCT LIST
          Expanded(
            child: products.isEmpty
                ? Center(
              child: Text(
                "${loc.getByKey('no_products')} ${loc.getByKey(categoryTitle)}",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: subTextColor,
                ),
              ),
            )
                : ListView.builder(
              padding:
              EdgeInsets.symmetric(horizontal: w * 0.04),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return _buildProductCard(
                  context,
                  products[index],
                  w,
                  loc,
                  isDark,
                  cardColor,
                  textColor,
                  subTextColor,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 🟢 PRODUCT CARD
  Widget _buildProductCard(
      BuildContext context,
      ProductModel product,
      double w,
      AppLocalizations loc,
      bool isDark,
      Color cardColor,
      Color textColor,
      Color subTextColor,
      ) {
    final cartProvider =
    Provider.of<CartProvider>(context, listen: false);

    final imageSize = w * 0.20;
    final padding = w * 0.03;

    return Card(
      margin: EdgeInsets.symmetric(vertical: w * 0.02),
      color: cardColor,
      elevation: isDark ? 0 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isDark
            ? BorderSide(color: Colors.white10)
            : BorderSide.none,
      ),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Row(
          children: [
            /// 🖼 IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                product.image,
                width: imageSize,
                height: imageSize,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(width: padding),

            /// 📝 DETAILS
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// PRODUCT NAME
                  Text(
                    loc.getByKey(product.name),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),

                  SizedBox(height: w * 0.01),

                  /// 💰 PRICE
                  Text(
                    product.price,
                    style: GoogleFonts.inter(
                      fontSize: w * 0.035,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            /// 🛒 ADD TO CART
            ElevatedButton.icon(
              onPressed: () {
                cartProvider.addItem({
                  "name": product.name,
                  "price": double.tryParse(
                    product.price
                        .replaceAll(RegExp(r'[^\d.]'), ''),
                  ) ??
                      0.0,
                  "qty": 1,
                  "image": product.image,
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.primary,
                    content: Text(
                      "${loc.getByKey(product.name)} ${loc.getByKey('added_to_cart')}",
                      style: GoogleFonts.inter(color: Colors.white),
                    ),
                    duration: const Duration(milliseconds: 900),
                  ),
                );
              },
              icon: Icon(
                Icons.shopping_bag,
                size: w * 0.045,
                color: Colors.white,
              ),
              label: Text(
                loc.getByKey('add'),
                style: GoogleFonts.inter(
                  fontSize: w * 0.035,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(
                  horizontal: w * 0.025,
                  vertical: w * 0.015,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
