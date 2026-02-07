import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../VendorProvider/hotel_provider.dart';
import '../models/hotel_model.dart';
import 'hotel_detail_screen.dart';

class VendorHotelScreen extends StatefulWidget {
  final String storeId;
  const VendorHotelScreen({super.key, required this.storeId});

  @override
  State<VendorHotelScreen> createState() => _VendorHotelScreenState();
}

class _VendorHotelScreenState extends State<VendorHotelScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();

  // Hotel basic info
  String? name, description, phone, email;
  String? street, city, state, pincode, landmark;
  String? latitude, longitude;

  // Hotel details
  String? totalRooms, checkInTime, checkOutTime;
  List<RoomType> roomTypes = [];
  List<String> amenities = [];

  List<File> images = [];
  bool isLoading = false;

  // Pick multiple images
  Future<void> pickImages() async {
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        images = pickedFiles.map((e) => File(e.path)).toList();
      });
    }
  }

  void addRoom() {
    setState(() {
      roomTypes.add(RoomType(name: "", pricePerNight: 0, maxGuests: 0));
    });
  }

  void addAmenity() {
    setState(() {
      amenities.add("");
    });
  }

  Future<void> submitHotel() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    final hotelData = {
      "vendorId": widget.storeId,
      "name": name,
      "description": description,
      "contact": {"phone": phone, "email": email},
      "address": {
        "street": street,
        "city": city,
        "state": state,
        "pincode": pincode,
        "landmark": landmark,
      },
      "geoLocation": {
        "lat": double.tryParse(latitude ?? "0") ?? 0,
        "lng": double.tryParse(longitude ?? "0") ?? 0,
      },
      "hotelDetails": {
        "totalRooms": int.tryParse(totalRooms ?? "0") ?? 0,
        "roomTypes": roomTypes
            .map((r) => {
          "name": r.name,
          "pricePerNight": r.pricePerNight,
          "maxGuests": r.maxGuests
        })
            .toList(),
        "amenities": amenities,
        "checkInTime": checkInTime ?? "",
        "checkOutTime": checkOutTime ?? "",
      },
      "hasRestaurant": false,
      "restaurant": {"cuisines": [], "images": []},
      "isActive": true,
    };

    setState(() => isLoading = true);

    final provider = Provider.of<VendorHotelProvider>(context, listen: false);
    final createdHotel = await provider.createHotel(hotelData);

    setState(() => isLoading = false);

    if (createdHotel != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Hotel Created Successfully")),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HotelDetailScreen(hotel: createdHotel),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to create hotel")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Hotel")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              buildTextField("Hotel Name", (val) => name = val),
              buildTextField("Description", (val) => description = val),
              buildTextField("Phone", (val) => phone = val),
              buildTextField("Email", (val) => email = val),
              buildTextField("Street", (val) => street = val),
              buildTextField("City", (val) => city = val),
              buildTextField("State", (val) => state = val),
              buildTextField("Pincode", (val) => pincode = val),
              buildTextField("Landmark", (val) => landmark = val),
              buildTextField("Latitude", (val) => latitude = val),
              buildTextField("Longitude", (val) => longitude = val),
              const SizedBox(height: 10),
              buildTextField("Total Rooms", (val) => totalRooms = val),
              const SizedBox(height: 10),

              // Room Types
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Room Types",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  ElevatedButton(onPressed: addRoom, child: const Text("Add Room")),
                ],
              ),
              ...roomTypes.asMap().entries.map((entry) {
                int index = entry.key;
                RoomType room = entry.value;
                return Column(
                  children: [
                    buildTextField("Room Name", (val) => roomTypes[index].name = val),
                    buildTextField(
                      "Price Per Night",
                          (val) => roomTypes[index].pricePerNight = double.tryParse(val) ?? 0,
                    ),
                    buildTextField(
                      "Max Guests",
                          (val) => roomTypes[index].maxGuests = int.tryParse(val) ?? 0,
                    ),
                  ],
                );
              }).toList(),

              const SizedBox(height: 10),

              // Amenities
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Amenities",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  ElevatedButton(onPressed: addAmenity, child: const Text("Add Amenity")),
                ],
              ),
              ...amenities.asMap().entries.map((entry) {
                int index = entry.key;
                return buildTextField("Amenity", (val) => amenities[index] = val);
              }).toList(),

              const SizedBox(height: 10),
              buildTextField("Check-In Time", (val) => checkInTime = val),
              buildTextField("Check-Out Time", (val) => checkOutTime = val),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: pickImages,
                  child: Text("Pick Images (${images.length})")),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading ? null : submitHotel,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, Function(String) onSaved) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (val) => val == null || val.isEmpty ? "Required" : null,
        onSaved: (val) => onSaved(val!),
        onChanged: (val) => onSaved(val),
      ),
    );
  }
}