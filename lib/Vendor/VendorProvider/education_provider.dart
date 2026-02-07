import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../vendor_screens/models/education_model.dart';

class EducationProvider extends ChangeNotifier {
  List<EducationModel> _educations = [];

  List<EducationModel> get educations => _educations;

  void addEducation(EducationModel education) {
    _educations.add(education);
    notifyListeners();
  }

  void removeEducation(int index) {
    _educations.removeAt(index);
    notifyListeners();
  }

  // ✅ Fetch all educations
  Future<void> fetchEducations() async {
    final url = Uri.parse("https://api.hazaribagmarket.in/education/getall");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data["success"] == true) {
          final List<EducationModel> loadedEducations = [];
          for (var edu in data["allData"]) {
            loadedEducations.add(EducationModel.fromJson(edu));
          }
          _educations = loadedEducations;
          notifyListeners();
        }
      } else {
        throw Exception("Failed to load educations");
      }
    } catch (e) {
      print("Error fetching educations: $e");
    }
  }

  // ✅ POST API to create a new education
  Future<bool> createEducation({
    required String name,
    required String type,
    required String description,
    required String mode,
    required String address,
    required String city,
    required String state,
    String? pincode,
    required String price,
    required String duration,
    required String schedule,
    required String ageGroup,
    required String phone,
    required String email,
    required String tags,
    File? imageFile,
    required String token,
  }) async {
    final uri = Uri.parse("https://api.hazaribagmarket.in/education/create");

    try {
      var request = http.MultipartRequest('POST', uri);

      // Add Authorization header
      request.headers['Authorization'] = "Bearer $token";

      // Add form fields
      request.fields['name'] = name;
      request.fields['type'] = type;
      request.fields['description'] = description;
      request.fields['mode'] = mode;
      request.fields['location[address]'] = address;
      request.fields['location[city]'] = city;
      request.fields['location[state]'] = state;
      request.fields['location[pincode]'] = pincode ?? '';
      request.fields['price'] = price;
      request.fields['duration'] = duration;
      request.fields['schedule'] = schedule;
      request.fields['ageGroup'] = ageGroup;
      request.fields['contact[phone]'] = phone;
      request.fields['contact[email]'] = email;
      request.fields['tags'] = tags;

      // Add image if available
      if (imageFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'images',
          imageFile.path,
        ));
      }

      // Send request
      final response = await request.send();
      final respStr = await response.stream.bytesToString();
      final data = json.decode(respStr);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (data['success'] == true) {
          // Add created education to provider list
          _educations.add(EducationModel.fromJson(data['data']));
          notifyListeners();
          return true;
        } else {
          print("API Error: ${data['message']}");
          return false;
        }
      } else {
        print("HTTP Error: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Submit Education Error: $e");
      return false;
    }
  }
}