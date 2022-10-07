class WeatherInfo {
  final String? description;
  final String? icon;

  WeatherInfo({this.description, this.icon});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final description = json['description'];
    final icon = json['icon'];
    return WeatherInfo(description: description, icon: icon);
  }
}

class TemperatureInfo {
  final double? temperature;
  final double? feel_like;
  final double? temp_min;
  final double? temp_max;
  final int? humidity;

  TemperatureInfo({
    this.temperature,
    this.temp_min,
    this.temp_max,
    this.feel_like,
    this.humidity,
  });

  factory TemperatureInfo.fromJson(Map<String, dynamic> json) {
    final temperature = json['temp'];
    final tempreaturemin = json['temp_min'];
    final tempreaturemax = json['temp_max'];
    final humidity = json['humidity'];
    final feel_like = json['feels_like'];
    return TemperatureInfo(
      temperature: temperature,
      feel_like: feel_like,
      temp_min: tempreaturemin,
      temp_max: tempreaturemax,
      humidity: humidity,
    );
  }
}

class WeatherResponse {
  final String? cityName;
  final TemperatureInfo? tempInfo;
  final WeatherInfo? weatherInfo;

  String get iconURL {
    return 'https://openweathermap.org/img/wn/${weatherInfo!.icon}@2x.png';
  }

  WeatherResponse({this.cityName, this.tempInfo, this.weatherInfo});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];

    final tempInfoJson = json['main'];
    final tempInfo = TemperatureInfo.fromJson(tempInfoJson);

    final weatherInfoJson = json['weather'][0];
    final weatherInfo = WeatherInfo.fromJson(weatherInfoJson);

    return WeatherResponse(
      cityName: cityName,
      tempInfo: tempInfo,
      weatherInfo: weatherInfo,
    );
  }
}
