import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/jobs_services_provider.dart';
import '../../../widgets/top_header.dart';
import 'job_details_screen.dart';

class JobsServicesScreen extends StatelessWidget {
  const JobsServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    final tabProvider = Provider.of<JobsServicesProvider>(context);

    /// ✅ FILTERED DATA
    final dataList = tabProvider.filteredList;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          const TopHeader(),

          SizedBox(height: h * 0.015),

          /// 🔙 BACK BUTTON
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.03),
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Row(
                children: [
                  Icon(Icons.arrow_back, color: Colors.red, size: w * 0.055),
                  SizedBox(width: w * 0.02),
                  Text(
                    "Back",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: w * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),


          SizedBox(height: h * 0.015),

          /// ✅ JOBS & SERVICES BANNER
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.03),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(w * 0.04),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(w * 0.04),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Jobs & Services",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: w * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Find opportunities and professional services in Hazaribagh",
                    style: TextStyle(color: Colors.white, fontSize: w * 0.03),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: h * 0.015),

          /// ✅ JOBS / SERVICES TOGGLE
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.03),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => tabProvider.selectJobs(),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: h * 0.012),
                        decoration: BoxDecoration(
                          color: tabProvider.isJobsSelected
                              ? Colors.red
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Jobs",
                            style: TextStyle(
                              color: tabProvider.isJobsSelected
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => tabProvider.selectServices(),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: h * 0.012),
                        decoration: BoxDecoration(
                          color: !tabProvider.isJobsSelected
                              ? Colors.red
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Services",
                            style: TextStyle(
                              color: !tabProvider.isJobsSelected
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: h * 0.015),

          /// ✅ FILTER BY CATEGORY
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.03),
            child: Container(
              padding: EdgeInsets.all(w * 0.03),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(w * 0.04),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 4),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.tune, color: Colors.purple),
                      const SizedBox(width: 6),
                      const Text(
                        "Filter By Category",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),

                      /// ✅ VIEW ALL NAVIGATION
                      Text(
                        "View All",
                        style: TextStyle(
                          color: Colors.blue, // ✅ Visible
                          fontSize: w * 0.03,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: h * 0.01),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _filterChip(
                          context, "All",
                          tabProvider.selectedCategory == "All"),
                      _filterChip(
                          context, "IT & Software",
                          tabProvider.selectedCategory == "IT & Software"),
                      _filterChip(
                          context, "Sales & Mark.",
                          tabProvider.selectedCategory == "Sales & Mark."),
                      _filterChip(
                          context, "Healthcare",
                          tabProvider.selectedCategory == "Healthcare"),
                      _filterChip(
                          context, "Education",
                          tabProvider.selectedCategory == "Education"),
                      _filterChip(
                          context, "Logistics",
                          tabProvider.selectedCategory == "Logistics"),
                    ],
                  ),
                ],
              ),
            ),
          ),

          /// ✅ GRID LIST
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(w * 0.03),
              itemCount: dataList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.62,
              ),
              itemBuilder: (context, index) {
                return _jobServiceCard(context, w, h, dataList[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ JOB CARD
  /// ✅ JOB CARD
  static Widget _jobServiceCard(
      BuildContext context, double w, double h, Map<String, String> job) {
    return Container(
      padding: EdgeInsets.all(w * 0.025),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w * 0.04),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(w * 0.03),
            child: Image.asset(
              'assets/images/electronics.jpg',
              height: h * 0.13,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(height: h * 0.008),

          Text(
            job["title"]!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style:
            TextStyle(fontWeight: FontWeight.bold, fontSize: w * 0.034),
          ),

          Text(
            job["company"]!,
            style: TextStyle(fontSize: w * 0.028, color: Colors.grey),
          ),

          SizedBox(height: h * 0.006),

          _jobRow(Icons.currency_rupee, job["salary"]!, w),
          _jobRow(Icons.work, job["type"]!, w),
          _jobRow(Icons.category, job["category"]!, w),

          const Spacer(),

          /// ✅ BUTTONS (FIXED)
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  // Use a consistent, slightly smaller height for better fit in the grid card
                  height: h * 0.045,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      // Remove minimum size to allow flexible sizing based on Expanded
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero, // Remove default padding
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(w * 0.02),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                          const JobDetailsScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "View Details",
                      style: TextStyle(
                        color: Colors.white,
                        // Increased font size and made it responsive to screen width
                        fontSize: w * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(width: w * 0.02),

              Expanded(
                child: SizedBox(
                  // Use the same height as the ElevatedButton for alignment
                  height: h * 0.045,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      // Customize border for the OutlinedButton
                      side: const BorderSide(color: Colors.grey, width: 1.5),
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(w * 0.02),
                      ),
                    ),
                    onPressed: () {
                      // Add your contact logic here
                    },
                    child: Text(
                      "Contact",
                      style: TextStyle(
                        color: Colors.black,
                        // Increased font size and made it responsive to screen width
                        fontSize: w * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  static Widget _jobRow(IconData icon, String title, double w) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: w * 0.004),
      child: Row(
        children: [
          Icon(icon, size: w * 0.03, color: Colors.red),
          SizedBox(width: w * 0.02),
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontSize: w * 0.026),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ CLICKABLE FILTER CHIP
  static Widget _filterChip(
      BuildContext context, String title, bool isActive) {
    final provider =
    Provider.of<JobsServicesProvider>(context, listen: false);

    return GestureDetector(
      onTap: () => provider.selectCategory(title),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.red : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
