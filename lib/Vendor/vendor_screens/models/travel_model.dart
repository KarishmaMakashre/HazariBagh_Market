class TravelModel {
  String vendor;
  String title;
  String tourType;
  String priceType;
  double priceAmount;
  String priceCurrency;
  int days;
  int nights;
  String description;
  String address;
  String city;
  String state;
  String country;
  double latitude;
  double longitude;
  String startDate;
  String endDate;

  TravelModel({
    required this.vendor,
    required this.title,
    required this.tourType,
    required this.priceType,
    required this.priceAmount,
    required this.priceCurrency,
    required this.days,
    required this.nights,
    required this.description,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.startDate,
    required this.endDate,
  });
}
