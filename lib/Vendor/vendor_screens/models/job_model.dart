class JobModel {
  final String id;
  final String title;
  final String description;
  final String jobType;
  final String subCategoryId;
  final String subCategoryName;
  final String requiredSkills;
  final int openings;
  final bool isRemote;
  final String status;
  final String? imagePath;
  final String? vendorId;

  final Location location;
  final Salary salary;
  final Experience experience;

  JobModel({
    required this.id,
    required this.title,
    required this.description,
    required this.jobType,
    required this.subCategoryId,
    required this.subCategoryName,
    required this.requiredSkills,
    required this.openings,
    required this.isRemote,
    required this.status,
    this.imagePath,
    this.vendorId,
    required this.location,
    required this.salary,
    required this.experience,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '-',
      description: json['description'] ?? '-',
      jobType: json['jobType'] ?? '-',
      subCategoryId: json['subCategoryId']?['_id'] ?? '',
      subCategoryName: json['subCategoryId']?['name'] ?? '-',
      requiredSkills: json['requiredSkills'] ?? '-',
      openings: json['openings'] ?? 0,
      isRemote: json['isRemote'] ?? false,
      status: json['status'] ?? '-',
      imagePath: json['image'],
      vendorId: json['vendorId']?['_id'],
      location: Location.fromJson(json['location'] ?? {}),
      salary: Salary.fromJson(json['salary'] ?? {}),
      experience: Experience.fromJson(json['experience'] ?? {}),
    );
  }
}

class Location {
  final String city;
  final String state;
  final String country;
  Location({required this.city, required this.state, required this.country});
  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      city: json['city'] ?? '-',
      state: json['state'] ?? '-',
      country: json['country'] ?? '-',
    );
  }
}

class Salary {
  final int min;
  final int max;
  final String currency;
  Salary({required this.min, required this.max, required this.currency});
  factory Salary.fromJson(Map<String, dynamic> json) {
    return Salary(
      min: json['min'] ?? 0,
      max: json['max'] ?? 0,
      currency: json['currency'] ?? '-',
    );
  }
}

class Experience {
  final int min;
  final int max;
  Experience({required this.min, required this.max});
  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      min: json['min'] ?? 0,
      max: json['max'] ?? 0,
    );
  }
}