class StoreModel {
  final String name;
  final String image;
  final String category;
  final String distance;
  final double rating;

  final String address;   // <–– added
  final String phone;     // <–– added
  final String time;      // <–– added

  StoreModel({
    required this.name,
    required this.image,
    required this.category,
    required this.distance,
    required this.rating,

    required this.address,
    required this.phone,
    required this.time,
  });
}

List<StoreModel> nearbyStores = [
  StoreModel(
    name: "Sharma Grocery Store",
    image: "assets/images/clothe.jpg",
    category: "Grocery",
    distance: "1.2 km",
    rating: 4.5,
    address: "Main Road, Hazaribagh",
    phone: "9876543210",
    time: "9:00 AM - 9:00 PM",
  ),

  StoreModel(
    name: "Delicious Food Point",
    image: "assets/images/kitchan.png",
    category: "Restaurant",
    distance: "2.1 km",
    rating: 4.3,
    address: "Sadar Chowk, Hazaribagh",
    phone: "9123456780",
    time: "10:00 AM - 11:00 PM",
  ),

  StoreModel(
    name: "Fashion Hub",
    image: "assets/images/electronics.jpg",
    category: "Fashion",
    distance: "850 m",
    rating: 4.6,
    address: "Mandai Market, Hazaribagh",
    phone: "9988776655",
    time: "11:00 AM - 8:00 PM",
  ),
];
