import 'package:flutter/material.dart';
import '../../colors/AppColors.dart';

class FaqScreenUpdated extends StatelessWidget {
  final List<String> faqs = [
    "How do I Track my order?",
    "What payment methods are accepted?",
    "How can I cancel my order?",
    "Is there a delivery fees?",
    "How do I become a vendor?",
    "What is your refund policy?",
  ];

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final w = mq.width;
    final h = mq.height;

    return Scaffold(
      backgroundColor: AppColors.bgLight,

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          /// 🟦 FAQ LIST CONTAINER
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(w * 0.04),

                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(w * 0.03),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: w * 0.03,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),

                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: faqs.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: w * 0.04,
                              vertical: h * 0.014,
                            ),
                            title: Text(
                              faqs[index],
                              style: TextStyle(
                                fontSize: w * 0.042,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textDark,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: w * 0.035,
                              color: AppColors.textGrey,
                            ),
                          ),

                          if (index != faqs.length - 1)
                            Divider(
                              height: 0,
                              color: AppColors.border,
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
