import 'package:flutter/material.dart';
import 'package:hazari_bagh_market/screen/All%20Categories/Grocery/product_list_screen.dart';
import 'package:provider/provider.dart';
import '../../../Model/grocery_model.dart';
import '../../../provider/grocery_provider.dart';
import '../../../widgets/top_header.dart';



// Change to StatelessWidget as state is now managed by Provider
class GroceryScreen extends StatelessWidget {
  const GroceryScreen({super.key});

  // 🟢 GROCERY CARD - Updated to include navigation logic
  Widget _groceryCard(BuildContext context, GroceryItem item, double w) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        // 🔑 NAVIGATION LOGIC ADDED
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductListScreen(
              categoryTitle: item.title, // Pass the category title to the next screen
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
            ),
          ],
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
                  item.image,
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
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    item.title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: w * 0.032,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final groceryProvider = context.watch<GroceryProvider>();
    final List<GroceryItem> groceryItems = groceryProvider.groceryItems;
    final bool isLoading = groceryProvider.isLoading;

    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [

          /// 🔝 TOP HEADER
          const TopHeader(),

          /// 🔙 BACK BUTTON + TITLE
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: 10),
            child: Row(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () => Navigator.pop(context),
                  child: const Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.arrow_back, size: 18),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  "Grocery",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          /// 🧺 GROCERY GRID
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(w * 0.04),
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                itemCount: groceryItems.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: w * 0.04,
                  mainAxisSpacing: w * 0.04,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  // 🔑 Pass context to the card builder for navigation
                  return _groceryCard(context, groceryItems[index], w);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}