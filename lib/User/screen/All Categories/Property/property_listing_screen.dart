import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Model/property_model.dart';
import '../../../../colors/AppColors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../provider/property_provider.dart';
import '../../../widgets/app_back_button.dart';
import '../../../widgets/top_header.dart';
import 'property_view_details_screen.dart';

class PropertyListingScreen extends StatelessWidget {
  const PropertyListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PropertyProvider>();
    final loc = AppLocalizations.of(context);

    final mq = MediaQuery.of(context);
    final w = mq.size.width;
    final h = mq.size.height;

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bool isMobile = w < 600;
    final bool isTablet = w >= 600 && w < 900;

    final int crossAxisCount = isMobile
        ? 2
        : isTablet
        ? 3
        : 4;

    return Scaffold(
      backgroundColor: Color(0xffF6F6F6FF),
      body: Column(
        children: [
          TopHeader(
          ),

          SizedBox(height: h * 0.015),

          /// 🔙 BACK BUTTON
          AppBackButton(
            width: w,
            color: AppColors.primary,
            text: loc.back,
          ),
          SizedBox(height: h * 0.015),

          /// MAIN BODY
          Expanded(
            child: CustomScrollView(
              slivers: [
                /// HEADER
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                    child: Container(
                      padding: EdgeInsets.all(w * 0.06),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary,
                            AppColors.primary.withOpacity(0.85),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(w * 0.04),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            loc.getByKey('property ListingTitle'),
                            style: theme.textTheme.titleLarge!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: h * 0.005),
                          Text(
                            loc.getByKey('property Listing Subtitle'),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall!.copyWith(
                              color: Colors.white.withOpacity(0.75),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                /// FILTER (STICKY)
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _FilterHeaderDelegate(
                    height: h * 0.28,
                    child: Container(
                      color: theme.scaffoldBackgroundColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: w * 0.06,
                        vertical: h * 0.01,
                      ),
                      child: Container(
                        padding: EdgeInsets.all(w * 0.03),
                        decoration: BoxDecoration(
                          color: theme.cardColor,
                          borderRadius: BorderRadius.circular(w * 0.04),
                          boxShadow: isDark
                              ? []
                              : [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: w * 0.02,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.tune,
                                  size: w * 0.018,
                                  color: AppColors.propertyAccent,
                                ),
                                SizedBox(width: w * 0.012),
                                Text(
                                  loc.getByKey('filter'),
                                  style: theme.textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: h * 0.015),

                            _sectionTitle(
                                context, loc.getByKey('property Type')),
                            SizedBox(height: h * 0.01),

                            Wrap(
                              spacing: w * 0.025,
                              runSpacing: h * 0.01,
                              children: ['all', 'For Rent', 'For Sale']
                                  .map(
                                    (type) => _filterChip(
                                  context: context,
                                  title: loc.getByKey(type),
                                  selected:
                                  provider.selectedType == type,
                                  onTap: () =>
                                      provider.setType(type),
                                  w: w,
                                ),
                              )
                                  .toList(),
                            ),

                            SizedBox(height: h * 0.015),

                            _sectionTitle(
                                context, loc.getByKey('category')),
                            SizedBox(height: h * 0.01),

                            Wrap(
                              spacing: w * 0.015,
                              runSpacing: h * 0.01,
                              children:
                              ['all', 'Flats', 'Home', 'PG', 'Land']
                                  .map(
                                    (cat) => _filterChip(
                                  context: context,
                                  title: loc.getByKey(cat),
                                  selected: provider
                                      .selectedCategory ==
                                      cat,
                                  onTap: () =>
                                      provider.setCategory(cat),
                                  w: w,
                                ),
                              )
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                /// PROPERTY GRID
                SliverPadding(
                  padding: EdgeInsets.all(w * 0.04),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        return _propertyCard(
                          context,
                          provider.filteredProperties[index],
                          loc,
                          w,
                          h,
                        );
                      },
                      childCount: provider.filteredProperties.length,
                    ),
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: w * 0.04,
                      mainAxisSpacing: w * 0.04,
                      mainAxisExtent:
                      isMobile ? h * 0.36 : h * 0.38,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// STICKY HEADER
class _FilterHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;

  _FilterHeaderDelegate({
    required this.height,
    required this.child,
  });

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      elevation: overlapsContent ? 4 : 0,
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

/// PROPERTY CARD
Widget _propertyCard(
    BuildContext context,
    PropertyModel property,
    AppLocalizations loc,
    double w,
    double h,
    ) {
  final theme = Theme.of(context);

  void openDetails() {
    context.read<PropertyProvider>().setSelectedProperty(property);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const PropertyDetailsScreen(),
      ),
    );
  }

  return GestureDetector(
    onTap: openDetails,
    child: Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(w * 0.04),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: w * 0.02,
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius:
            BorderRadius.vertical(top: Radius.circular(w * 0.04)),
            child: Image.asset(
              property.image,
              height: h * 0.18,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(w * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: h * 0.004),
                  _infoRow(context, Icons.location_on,
                      property.location, w),
                  _infoRow(
                      context, Icons.square_foot, property.area, w),
                  _infoRow(
                      context, Icons.bed, property.bedInfo, w),
                  const Spacer(),

                  /// VIEW DETAILS BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: h * 0.045,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(w * 0.03),
                        ),
                      ),
                      onPressed: openDetails,
                      child: Text(
                        loc.getByKey('viewDetails'),
                        style: TextStyle(fontSize: w * 0.03),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

/// FILTER CHIP
Widget _filterChip({
  required BuildContext context,
  required String title,
  required bool selected,
  required VoidCallback onTap,
  required double w,
}) {
  final theme = Theme.of(context);

  return InkWell(
    borderRadius: BorderRadius.circular(w * 0.05),
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: w * 0.035,
        vertical: w * 0.025,
      ),
      decoration: BoxDecoration(
        color: selected
            ? AppColors.primary
            : theme.dividerColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(w * 0.05),
      ),
      child: Text(
        title,
        style: theme.textTheme.bodySmall!.copyWith(
          color: selected ? Colors.white : theme.textTheme.bodyMedium!.color,
        ),
      ),
    ),
  );
}

/// INFO ROW
Widget _infoRow(
    BuildContext context, IconData icon, String text, double w) {
  final theme = Theme.of(context);
  return Padding(
    padding: EdgeInsets.only(bottom: w * 0.01),
    child: Row(
      children: [
        Icon(icon, size: w * 0.035),
        SizedBox(width: w * 0.015),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall,
          ),
        ),
      ],
    ),
  );
}

/// SECTION TITLE
Widget _sectionTitle(BuildContext context, String text) {
  return Text(
    text,
    style: Theme.of(context)
        .textTheme
        .bodySmall!
        .copyWith(fontWeight: FontWeight.w600),
  );
}
