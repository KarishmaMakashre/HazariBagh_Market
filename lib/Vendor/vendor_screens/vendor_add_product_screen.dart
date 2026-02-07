import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../VendorProvider/category_provider.dart';
import 'models/category_model.dart';

class VendorAddProductScreen extends StatefulWidget {
  final String storeId;

  const VendorAddProductScreen({
    super.key,
    required this.storeId,
  });

  @override
  State<VendorAddProductScreen> createState() =>
      _VendorAddProductScreenState();
}

class _VendorAddProductScreenState extends State<VendorAddProductScreen> {
  @override
  void initState() {
    super.initState();

    /// Fetch categories after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoryProvider>().getAllCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Consumer<CategoryProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.categoryList.isEmpty) {
            return const Center(child: Text("No Categories Found"));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.categoryList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 0.78,
            ),
            itemBuilder: (context, index) {
              final CategoryModel category =
              provider.categoryList[index];

              final assetImage = categoryAssetMap[category.name];

              return GestureDetector(
                onTap: () {
                  /// Load data for selected category
                  context
                      .read<CategoryProvider>()
                      .fetchByCategory(category.name);

                  final screenBuilder =
                  categoryScreenMap[category.name];

                  if (screenBuilder != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            screenBuilder(widget.storeId),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "No screen found for ${category.name}",
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: assetImage != null
                              ? Image.asset(
                            assetImage,
                            fit: BoxFit.contain,
                          )
                              : const Icon(
                            Icons.image_not_supported,
                            size: 40,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          category.name,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}