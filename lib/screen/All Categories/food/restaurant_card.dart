import 'package:flutter/material.dart';
import 'RestaurantDetailsScreen.dart';

class RestaurantCard extends StatelessWidget {
  final Size size;
  final String img;
  final String name;
  final String type;
  final String rating;
  final String time;
  final String distance;

  const RestaurantCard({
    super.key,
    required this.size,
    required this.img,
    required this.name,
    required this.type,
    required this.rating,
    required this.time,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    final width = size.width;
    final height = size.height;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RestaurantDetailsScreen(
              img: img,
              name: name,
              type: type,
              rating: rating,
              time: time,
              distance: distance,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(width * 0.035),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(width * 0.035),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(width * 0.03),
              child: Image.asset(
                img,
                width: width * 0.22,
                height: width * 0.22,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(width: width * 0.035),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: width * 0.048,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: height * 0.005),

                  Text(
                    type,
                    style: TextStyle(
                      fontSize: width * 0.035,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: height * 0.01),

                  Row(
                    children: [
                      Icon(Icons.star,
                          color: Colors.amber, size: width * 0.045),
                      SizedBox(width: 4),
                      Text(
                        rating,
                        style: TextStyle(fontSize: width * 0.035),
                      ),
                      SizedBox(width: width * 0.03),

                      Icon(Icons.timer_outlined, size: width * 0.045),
                      SizedBox(width: 4),
                      Text(
                        time,
                        style: TextStyle(fontSize: width * 0.035),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Icon(Icons.location_on,
                          color: Colors.red, size: width * 0.045),
                      SizedBox(width: 4),
                      Text(
                        distance,
                        style: TextStyle(fontSize: width * 0.035),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
