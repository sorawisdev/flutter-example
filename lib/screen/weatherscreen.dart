import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:weather_app/model/model.dart';
import 'package:weather_app/screen/more_info.dart';
import 'package:weather_app/service/data_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final _latTextController = TextEditingController();
  // final _lonTextController = TextEditingController();
  final _dataService = dataService();
  late final lat, lng;
  WeatherResponse? _response;

  @override
  void initState() {
    super.initState();
    findLatLng();
  }

  Future<Null> findLatLng() async {
    LocationData? locationData = await findLocationData();
    lat = locationData?.latitude;
    lng = locationData?.longitude;
    // print('latitude ${lat}, lontitude ${lng}');
  }

  Future<LocationData?> findLocationData() async {
    Location location = Location();
    try {
      return location.getLocation();
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(), // Head app bar
            if (_response != null)
              Column(
                children: [
                  Image.network(_response!.iconURL),
                  Text(
                    '${_response!.tempInfo!.temperature}°C',
                    style: const TextStyle(
                      fontSize: 40,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${_response!.cityName}',
                        style: const TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        '${_response!.weatherInfo!.description}',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Divider(),
                  moreInformation(
                    '${_response!.tempInfo!.temp_min}',
                    '${_response!.tempInfo!.temp_max}',
                    '${_response!.tempInfo!.feel_like}',
                    '${_response!.tempInfo!.humidity}',
                  ),
                ],
              ),
            // Padding(
            //   padding: EdgeInsets.symmetric(vertical: 50),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       SizedBox(
            //         width: 150,
            //         child: TextField(
            //           controller: _latTextController,
            //           decoration: InputDecoration(labelText: 'Latitude'),
            //           textAlign: TextAlign.start,
            //         ),
            //       ),
            //       const SizedBox(
            //         width: 20,
            //       ),
            //       SizedBox(
            //         width: 150,
            //         child: TextField(
            //           controller: _lonTextController,
            //           decoration: InputDecoration(labelText: 'Lontitude'),
            //           textAlign: TextAlign.start,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            SizedBox(
              height: 50,
            ),
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: _search,
                      child: Text("Current Weather"),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueGrey, // background
                        onPrimary: Colors.white, // foreground
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Edit Profile",
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent, // background
                        onPrimary: Colors.white, // foreground
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Logout",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _search() async {
    final response = await _dataService.getWeather(
      // _latTextController.text,
      // _lonTextController.text,
      lat.toString(), lng.toString(),
    );
    setState(() {
      _response = response;
    });
  }
}
