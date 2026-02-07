import 'package:flutter/material.dart';
import '../models/hotel_model.dart';

class HotelDetailScreen extends StatelessWidget {
  final Hotel hotel;

  const HotelDetailScreen({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(hotel.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Description: ${hotel.description}"),
              const SizedBox(height: 10),
              Text("Phone: ${hotel.contact.phone}"),
              Text("Email: ${hotel.contact.email}"),
              const SizedBox(height: 10),
              Text(
                  "Address: ${hotel.address.street}, ${hotel.address.city}, ${hotel.address.state} - ${hotel.address.pincode}"),
              Text("Landmark: ${hotel.address.landmark}"),
              const SizedBox(height: 10),
              Text("Total Rooms: ${hotel.hotelDetails.totalRooms}"),
              Text("Check-in: ${hotel.hotelDetails.checkInTime}"),
              Text("Check-out: ${hotel.hotelDetails.checkOutTime}"),
              const SizedBox(height: 10),
              Text("Amenities: ${hotel.hotelDetails.amenities.join(', ')}"),
              const SizedBox(height: 10),
              Text("Rooms:"),
              ...hotel.hotelDetails.roomTypes.map(
                    (room) => Text(
                    "${room.name} - ₹${room.pricePerNight} / ${room.maxGuests} guests"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}