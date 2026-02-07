class ApiEndpoints {
  static const String baseUrl = "https://api.hazaribagmarket.in";

  static const Map<String, String> categoryApiMap = {
    "Tour and Travels": "/tour/getAllTours",
    "Agriculture": "/agriculture/getall",
    "Government Services": "/service/getall",
    "Educations": "/education/getall",
    "Properties": "/property/getallproperties",
    "Jobs": "/jobs/getalljobs",
  };
}