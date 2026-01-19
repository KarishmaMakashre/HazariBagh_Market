import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../../../../colors/AppColors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../provider/jobs_services_provider.dart';
import '../../../widgets/app_back_button.dart';
import '../../../widgets/top_header.dart';
import 'job_details_screen.dart';

class JobsServicesScreen extends StatefulWidget {
  const JobsServicesScreen({super.key});

  @override
  State<JobsServicesScreen> createState() => _JobsServicesScreenState();
}

class _JobsServicesScreenState extends State<JobsServicesScreen> {
  late VideoPlayerController _welcomeVideoController;

  final String welcomeVideoAsset = "assets/Videos/shopAds.mp4";

  final PageController _pageController = PageController();
  final List<String> bigSaleImages = [
    "assets/images/Fruits.jpg",
    "assets/images/clothe.jpg",
    "assets/images/grocery.jpg",
  ];

  @override
  void initState() {
    super.initState();
    _welcomeVideoController = VideoPlayerController.asset(welcomeVideoAsset)
      ..initialize().then((_) {
        if (!mounted) return;
        _welcomeVideoController
          ..setLooping(true)
          ..setVolume(0)
          ..play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    _welcomeVideoController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark ? const Color(0xFF0F172A) : const Color(0xFFF5F7FA);
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF1E293B);
    final subTextColor =
    isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    final shadow = [
      BoxShadow(
        color: isDark ? Colors.black54 : Colors.black12,
        blurRadius: 12,
        offset: const Offset(0, 6),
      ),
    ];

    final provider = context.watch<JobsServicesProvider>();
    final dataList = provider.filteredList;

    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          const TopHeader(),

          SizedBox(height: h * 0.015),

          /// 🔙 BACK BUTTON
          AppBackButton(
            width: w,
            color: AppColors.primary,
            text: loc.back,
          ),

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  /// 🎥 VIDEO
                  Padding(
                    padding: EdgeInsets.all(w * 0.04),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: SizedBox(
                        height: h * 0.18,
                        width: double.infinity,
                        child: _welcomeVideoController.value.isInitialized
                            ? FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                            width: _welcomeVideoController
                                .value.size.width,
                            height: _welcomeVideoController
                                .value.size.height,
                            child: VideoPlayer(
                                _welcomeVideoController),
                          ),
                        )
                            : const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ),

                  /// 🖼️ SLIDER
                  SizedBox(
                    height: h * 0.18,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: bigSaleImages.length,
                      itemBuilder: (_, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: Image.asset(
                              bigSaleImages[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: h * 0.03),

                  /// 🔁 TOGGLE
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: shadow,
                      ),
                      child: Row(
                        children: [
                          _toggleTab(
                            title: loc.jobs,
                            isActive: provider.isJobsSelected,
                            onTap: provider.selectJobs,
                            h: h,
                          ),
                          const SizedBox(width: 8),
                          _toggleTab(
                            title: loc.services,
                            isActive: !provider.isJobsSelected,
                            onTap: provider.selectServices,
                            h: h,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: h * 0.02),

                  /// 🎯 FILTER
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                    child: Container(
                      padding: EdgeInsets.all(w * 0.04),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: shadow,
                      ),
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _filterChip(context, loc.getByKey("all"), "all", isDark),
                          _filterChip(context, loc.getByKey("itSoftware"),
                              "itSoftware", isDark),
                          _filterChip(context, loc.getByKey("salesMarketing"),
                              "salesMarketing", isDark),
                          _filterChip(context, loc.getByKey("healthcare"),
                              "healthcare", isDark),
                          _filterChip(context, loc.getByKey("education"),
                              "education", isDark),
                          _filterChip(context, loc.getByKey("logistics"),
                              "logistics", isDark),
                        ],
                      ),
                    ),
                  ),

                  /// 🧾 GRID
                  GridView.builder(
                    padding: EdgeInsets.all(w * 0.04),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dataList.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.66,
                    ),
                    itemBuilder: (_, index) {
                      return _jobServiceCard(
                        context,
                        w,
                        h,
                        dataList[index],
                        loc,
                        cardColor,
                        textColor,
                        subTextColor,
                        shadow,
                        isDark,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 🔘 TOGGLE TAB
Widget _toggleTab({
  required String title,
  required bool isActive,
  required VoidCallback onTap,
  required double h,
}) {
  return Expanded(
    child: InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: h * 0.05,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.grey,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
  );
}

/// 🎴 JOB CARD
Widget _jobServiceCard(
    BuildContext context,
    double w,
    double h,
    Map<String, String> job,
    AppLocalizations loc,
    Color cardColor,
    Color textColor,
    Color subTextColor,
    List<BoxShadow> shadow,
    bool isDark,
    ) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const JobDetailsScreen()),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: shadow,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.asset(
                'assets/images/electronics.jpg',
                height: h * 0.12,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(w * 0.035),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loc.getByKey(job["titleKey"]!),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: w * 0.035,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      loc.getByKey(job["companyKey"]!),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: w * 0.028,
                        color: subTextColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    _jobRow(Icons.currency_rupee, job["salary"]!, w, isDark),
                    _jobRow(Icons.work,
                        loc.getByKey(job["typeKey"]!), w, isDark),
                    const Spacer(),
                    SizedBox(
                      height: h * 0.04,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const JobDetailsScreen()),
                        ),
                        child: Text(
                          loc.viewDetails,
                          style: TextStyle(
                            fontSize: w * 0.03,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
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
    ),
  );
}

Widget _jobRow(
    IconData icon, String title, double w, bool isDark) {
  return Row(
    children: [
      Icon(icon, size: w * 0.032, color: AppColors.primary),
      SizedBox(width: w * 0.02),
      Expanded(
        child: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: w * 0.027,
            color: isDark ? Colors.white70 : Colors.black87,
          ),
        ),
      ),
    ],
  );
}

/// 🔘 FILTER CHIP
Widget _filterChip(
    BuildContext context, String title, String key, bool isDark) {
  final provider =
  Provider.of<JobsServicesProvider>(context, listen: false);
  final isActive = provider.selectedCategoryKey == key;

  return InkWell(
    borderRadius: BorderRadius.circular(20),
    onTap: () => provider.selectCategory(key),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.primary
            : isDark
            ? const Color(0xFF1F2937)
            : const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isActive ? Colors.white : Colors.grey.shade800,
        ),
      ),
    ),
  );
}
