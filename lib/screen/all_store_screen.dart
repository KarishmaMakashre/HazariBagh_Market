import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/screen/store_details_screen.dart';
import '../../widgets/top_header.dart';
import '../Model/store_model.dart';

class AllStoreScreen extends StatelessWidget {
  const AllStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final w = mq.width;
    final h = mq.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          const TopHeader(),

          /// 🔙 BACK + TITLE (MediaQuery based)
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: w * 0.04,
              vertical: h * 0.015,
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                ),
              ],
            ),
            child: InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(30),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(w * 0.015),
                    child: Icon(
                      Icons.arrow_back,
                      size: w * 0.05,
                    ),
                  ),
                  SizedBox(width: w * 0.03),
                  Text(
                    "All Stores",
                    style: TextStyle(
                      fontSize: w * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),


          /// 🏬 STORE LIST
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(w * 0.04),
              itemCount: nearbyStores.length,
              itemBuilder: (context, index) {
                final store = nearbyStores[index];

                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: Duration(milliseconds: 300 + index * 100),
                  builder: (_, value, child) => Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, (1 - value) * 40),
                      child: child,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration:
                          const Duration(milliseconds: 350),
                          pageBuilder: (_, a, __) => FadeTransition(
                            opacity: a,
                            child: StoreDetailsScreen(store: store),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          /// IMAGE
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  store.image,
                                  height: h * 0.10,
                                  width: w * 0.22,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 6,
                                right: 6,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        size: 12,
                                        color: Colors.orange,
                                      ),
                                      const SizedBox(width: 2),
                                      Text(
                                        "${store.rating}",
                                        style:
                                        const TextStyle(fontSize: 11),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(width: w * 0.03),

                          /// DETAILS
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  store.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: w * 0.04,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: h * 0.004),
                                Text(
                                  store.category,
                                  style: TextStyle(
                                    fontSize: w * 0.032,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: h * 0.006),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      size: 14,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      store.distance,
                                      style: TextStyle(
                                        fontSize: w * 0.032,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          /// ➡️ ARROW
                          Icon(
                            Icons.arrow_forward_ios,
                            size: w * 0.04,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
