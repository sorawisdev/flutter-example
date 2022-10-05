import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/model/model.dart';

//https://api.openweathermap.org/data/2.5/weather?lat=18.7883&lon=98.9853&appid=da1dfa292f60d2fa3c4158adfd1f35e1

class dataService {
  Future<WeatherResponse> getWeather(String lat, String lon) async {
    final queryParameters = {
      'lat': lat,
      'lon': lon,
      'appid': 'da1dfa292f60d2fa3c4158adfd1f35e1',
      'units': 'metric',
    };

    final uri = Uri.https(
        'api.openweathermap.org', 'data/2.5/weather', queryParameters);
    final response = await http.get(uri);

    final json = jsonDecode(response.body);
    return WeatherResponse.fromJson(json);
  }
}
