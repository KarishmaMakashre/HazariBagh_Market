import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../provider/store_provider.dart';

class StoreDetailsScreen extends StatelessWidget {
  const StoreDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final storeProvider = context.watch<StoreProvider>();
    final store = storeProvider.selectedStore;

    if (store == null) {
      return const Scaffold(
        body: Center(child: Text("No Store Selected")),
      );
    }

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      /// 🌈 APP BAR
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          store.name,
          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
        ),
        flexibleSpace: const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF3670A3), Color(0xFF4B8AC9)],
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🖼 STORE IMAGE
            Stack(
              children: [
                Image.asset(
                  store.image,
                  height: size.height * 0.30,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: _ratingChip(store.rating),
                ),
              ],
            ),

            /// 📦 CONTENT
            Container(
              transform: Matrix4.translationValues(0, -20, 0),
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    store.name,
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// CATEGORY
                  _categoryChip(store.category),

                  const SizedBox(height: 16),

                  /// INFO ROW
                  Row(
                    children: [
                      _infoItem(
                        icon: Icons.location_on,
                        text: store.distance,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 20),
                      _infoItem(
                        icon: Icons.star,
                        text: store.rating.toString(),
                        color: Colors.orange,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                  Divider(color: Colors.grey.shade300),
                  const SizedBox(height: 16),

                  /// ABOUT
                  Text(
                    "About Store",
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "This store provides quality products at affordable prices. "
                        "Customer satisfaction and fast service is our priority.",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      height: 1.5,
                      color: Colors.grey.shade700,
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// VISIT BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3670A3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Visit Store",
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 UI HELPERS
  Widget _ratingChip(double rating) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.star, color: Colors.orange, size: 16),
          const SizedBox(width: 4),
          Text(
            rating.toString(),
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoryChip(String category) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        category,
        style: GoogleFonts.inter(
          fontSize: 13,
          color: const Color(0xFF3670A3),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _infoItem({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 4),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
