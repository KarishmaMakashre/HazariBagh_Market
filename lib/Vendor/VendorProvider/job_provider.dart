import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../vendor_screens/models/job_model.dart';
import '../vendor_screens/utils/api_constants.dart';

class JobProvider extends ChangeNotifier {
  bool isLoading = false;
  final List<JobModel> _jobs = [];
  List<JobModel> get jobs => _jobs;

  /// ================= GET ALL JOBS =================
  Future<void> getAllJobs() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse("${ApiConstants.baseUrl}/jobs/getalljobs"),
        headers: ApiConstants.authHeader, // use the token here
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true && data['jobs'] != null) {
          final List jobsList = data['jobs'];
          _jobs.clear();
          for (var item in jobsList) {
            _jobs.add(JobModel.fromJson(item));
          }
        }
      } else {
        debugPrint("Failed to fetch jobs. Status: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching jobs: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// ================= CREATE JOB =================
  Future<bool> createJob(JobModel job) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse("${ApiConstants.baseUrl}/jobs/createjob"),
        headers: {
          "Content-Type": "application/json",
          ...ApiConstants.authHeader, // use token here too
        },
        body: jsonEncode({
          "title": job.title,
          "description": job.description,
          "jobType": job.jobType,
          "subCategoryId": job.subCategoryId,
          "requiredSkills": job.requiredSkills,
          "openings": job.openings,
          "isRemote": job.isRemote,
          "status": job.status,
          "location": {
            "city": job.location.city,
            "state": job.location.state,
            "country": job.location.country,
          },
          "salary": {
            "min": job.salary.min,
            "max": job.salary.max,
            "currency": job.salary.currency,
          },
          "experience": {
            "min": job.experience.min,
            "max": job.experience.max,
          },
          "image": job.imagePath,
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true && data['job'] != null) {
          _jobs.insert(0, JobModel.fromJson(data['job']));
          return true;
        }
        return false;
      } else {
        debugPrint("Failed to create job. Status: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      debugPrint("Error creating job: $e");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}