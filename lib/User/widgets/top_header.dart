import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../colors/AppColors.dart';
import '../provider/cart_provider.dart';
import '../screen/cart/cart_page.dart';
import '../screen/notification_screen.dart';
import '../screen/profile_screen.dart';

class TopHeader extends StatelessWidget {
  final bool hideProfileIcon;

  const TopHeader({
    super.key,
    this.hideProfileIcon = false, // default = show
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final width = mq.width;
    final height = mq.height;

    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(width * 0.05),
        bottomRight: Radius.circular(width * 0.05),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.012,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryBlue,
              AppColors.primaryOrange,
            ],
          ),
        ),

        child: SafeArea(
          bottom: false,
          child: Row(
            children: [
              /// LOGO
              /// LOGO + WELCOME + LOCATION
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Container(
                      height: width * 0.10,
                      width: width * 0.10,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(width * 0.03),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(width * 0.020),
                        child: Image.asset(
                          "assets/images/HazariBaghLogo-removebg.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    SizedBox(width: width * 0.03),

                    /// WELCOME + LOCATION
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Ratanlok Colony, Indore",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: width * 0.030,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),


              const Spacer(),


              _iconButton(
                context,
                Icons.notifications,
                const NotificationScreen(),
                width,
              ),
              SizedBox(width: width * 0.04),

              /// 🛒 CART
              Consumer<CartProvider>(
                builder: (context, cart, child) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CartScreen(),
                        ),
                      );
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                          size: width * 0.065,
                        ),
                        if (cart.cartCount > 0)
                          Positioned(
                            right: -4,
                            top: -4,
                            child: Container(
                              padding: EdgeInsets.all(width * 0.01),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                cart.cartCount.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width * 0.025,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),


                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconButton(
      BuildContext context,
      IconData icon,
      Widget page,
      double size,
      ) {
    return GestureDetector(
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
      child: Icon(icon, color: Colors.white, size: size * 0.065),
    );
  }
}
