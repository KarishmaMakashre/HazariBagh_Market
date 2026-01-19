import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../provider/hotel_provider.dart';
import '../../../widgets/app_back_button.dart';
import '../../../widgets/top_header.dart';
import 'hotel_category_card.dart';
import '../../../../colors/AppColors.dart';

class HotelScreen extends StatelessWidget {
  const HotelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hotelProvider = context.watch<HotelProvider>();
    final w = MediaQuery.of(context).size.width;
    final loc = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Color(0xffF6F6F6FF),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// 🔝 TOP HEADER
          const TopHeader(),

          const SizedBox(height: 2),

          /// 🔙 BACK BUTTON (PRIMARY COLOR)
          AppBackButton(
            width: w,
            color: AppColors.primary, // ✅ main blue
            text: loc.back,
          ),

          // const SizedBox(height: 2),

          /// 🏨 HOTEL CATEGORIES GRID
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(w * 0.04),
              child: hotelProvider.isLoading
                  ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryDark, // ✅ dark blue loader
                ),
              )
                  : GridView.builder(
                itemCount: hotelProvider.categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: w * 0.04,
                  mainAxisSpacing: w * 0.04,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  return HotelCategoryCard(
                    category: hotelProvider.categories[index],
                    width: w,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
