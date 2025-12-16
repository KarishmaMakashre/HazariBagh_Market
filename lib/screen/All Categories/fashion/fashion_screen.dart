import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hazari_bagh_market/widgets/top_header.dart';
import '../../../provider/fashion_provider.dart';
import '../../../colors/AppColors.dart';
import 'service_detail_screen.dart';

class FashionScreen extends StatefulWidget {
  const FashionScreen({super.key});

  @override
  State<FashionScreen> createState() => _FashionScreenState();
}

class _FashionScreenState extends State<FashionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FashionProvider>();
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: FadeTransition(
        opacity: _fade,
        child: SlideTransition(
          position: _slide,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TopHeader(),
                SizedBox(height: h * 0.01),

                /// 🔙 BACK
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: w * 0.04, vertical: h * 0.01),
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back,
                            color: AppColors.primary, size: w * 0.06),
                        SizedBox(width: w * 0.02),
                        Text(
                          "Back",
                          style: TextStyle(
                            fontSize: w * 0.045,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// 🔵 BANNER
                Padding(
                  padding: EdgeInsets.all(w * 0.02),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: w * 0.05, vertical: h * 0.025),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Fashion Store",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: w * 0.055,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: h * 0.008),
                        Text(
                          "Explore latest fashion & trends",
                          style: TextStyle(
                            color: AppColors.textGrey,
                            fontSize: w * 0.035,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: h * 0.03),

                /// 📂 CATEGORIES (Fade-in images)
                _sectionTitle("Categories", w),
                SizedBox(height: h * 0.015),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                  child: Row(
                    children: provider.categories.map((cat) {
                      return Expanded(
                        child: AnimatedOpacity(
                          opacity: 1,
                          duration: const Duration(milliseconds: 800),
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            height: h * 0.14,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Image.asset(
                                    cat.image,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        AppColors.black.withOpacity(0.6),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 12,
                                  bottom: 12,
                                  child: Text(
                                    cat.title,
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: w * 0.04,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                SizedBox(height: h * 0.03),

                /// 🛍 SERVICES (Tap scale animation)
                _sectionTitle("Services", w),
                SizedBox(height: h * 0.015),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.services.length,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: w * 0.03,
                      mainAxisSpacing: w * 0.03,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      final service = provider.services[index];

                      return TweenAnimationBuilder<double>(
                        tween: Tween(begin: 1, end: 1),
                        duration: const Duration(milliseconds: 200),
                        builder: (_, scale, child) {
                          return Transform.scale(
                            scale: scale,
                            child: child,
                          );
                        },
                        child: InkWell(
                          borderRadius:
                          BorderRadius.circular(w * 0.035),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ServiceListScreen(),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius:
                              BorderRadius.circular(w * 0.035),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.shadow,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(w * 0.035),
                                    ),
                                    child: Hero(
                                      tag: service.image,
                                      child: Image.asset(
                                        service.image,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Center(
                                    child: Text(
                                      service.title.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: w * 0.028,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textDark,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: h * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, double w) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.04),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.primary,
          fontSize: w * 0.045,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
