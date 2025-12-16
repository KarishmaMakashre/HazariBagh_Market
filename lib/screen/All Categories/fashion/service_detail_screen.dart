import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/widgets/top_header.dart';

import '../../../colors/AppColors.dart';

class ServiceListScreen extends StatelessWidget {
  const ServiceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        child: Column(
          children: [
            TopHeader(),
            /// 🔵 TOP HEADER
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: w * 0.04,
                vertical: h * 0.015,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.primary,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: w * 0.01),
                  Text(
                    "Beauty & Salon",
                    style: TextStyle(
                      fontSize: w * 0.05,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                ],
              ),
            ),

            /// 📜 LIST
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(w * 0.03),
                children: const [
                  ServiceCard(
                    image: "assets/images/man.jpg",
                    name: "Shrangarika Beauty Parlour",
                    rating: "4.0",
                    reviews: "153 Ratings",
                    location:
                    "Agarwal Main Road Sapna Sangeeta Road, Indore",
                    phone: "07947291738",
                  ),
                  ServiceCard(
                    image: "assets/images/woman.jpg",
                    name: "Tathastu Family Salon and Spa Academy",
                    rating: "4.6",
                    reviews: "222 Ratings",
                    location: "Scheme No. 140 Pipliyahana, Indore",
                    phone: "08147458315",
                  ),
                  ServiceCard(
                    image: "assets/images/man.jpg",
                    name: "Saumyas Makeover Club",
                    rating: "4.3",
                    reviews: "39 Ratings",
                    location:
                    "SBI Basera Apartment Vishnupuri Main Road, Indore",
                    phone: "08519806084",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String image;
  final String name;
  final String rating;
  final String reviews;
  final String location;
  final String phone;

  const ServiceCard({
    super.key,
    required this.image,
    required this.name,
    required this.rating,
    required this.reviews,
    required this.location,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(bottom: h * 0.02),
      padding: EdgeInsets.all(w * 0.03),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          /// 🔝 TOP CONTENT
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// IMAGE
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  image,
                  height: h * 0.12,
                  width: h * 0.12,
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(width: w * 0.03),

              /// DETAILS
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: w * 0.045,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),

                    SizedBox(height: h * 0.006),

                    /// ⭐ RATING
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.success,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              Text(
                                rating,
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 2),
                              const Icon(
                                Icons.star,
                                size: 14,
                                color: AppColors.white,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: w * 0.02),
                        Text(
                          reviews,
                          style: TextStyle(
                            fontSize: w * 0.03,
                            color: AppColors.textGrey,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: h * 0.006),

                    /// 📍 LOCATION
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 16,
                          color: AppColors.textGrey,
                        ),
                        SizedBox(width: w * 0.01),
                        Expanded(
                          child: Text(
                            location,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: w * 0.03,
                              color: AppColors.textLight,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: h * 0.008),

                    /// 🏷️ TAG
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.bgLight,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        "Home Services Offered",
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: h * 0.015),

          /// 🔘 ACTION ICONS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _actionIcon(Icons.call, AppColors.primary),
              _actionIcon(Icons.chat, AppColors.success), // WhatsApp alternative
              _actionIcon(Icons.sms, AppColors.linkBlue),
            ],
          ),
        ],
      ),
    );
  }

  /// 🔘 ICON STYLE
  Widget _actionIcon(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color),
    );
  }
}
