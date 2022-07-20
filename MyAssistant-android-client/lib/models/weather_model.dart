class WeatherModel {
  double? temperature;
  String? description;
  String? location;

  WeatherModel({this.temperature, this.description});

  WeatherModel.fromJson(Map<String, dynamic> json) {
    temperature = json['main']['temp'];
    description = json['weather'][0]['description'];
    location = json['name'];
  }
}
