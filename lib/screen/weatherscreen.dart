import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:weather_app/model/model.dart';
import 'package:weather_app/screen/change_password.dart';
import 'package:weather_app/screen/head.dart';
import 'package:weather_app/screen/homescreen.dart';
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

  loc.Location location = loc.Location();

  @override
  void initState() {
    super.initState();
    findLatLng();
  }

  Future findLatLng() async {
    loc.LocationData? locationData = await _findLocationData();
    lat = locationData!.latitude;
    lng = locationData.longitude;
    // print('latitude ${lat}, lontitude ${lng}');
  }

  // Future<loc.LocationData> findLocationData() async {
  //   loc.Location location = loc.Location();
  //   try {
  //     return location.getLocation();
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // check request if GPS not open
  Future _findLocationData() async {
    if (!await location.serviceEnabled()) {
      location.requestService();
    } else {
      return location.getLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;

    var temp = _response?.tempInfo!.temperature!.round() ?? 0;
    var min_temp = _response?.tempInfo!.temp_min!.round() ?? 0;
    var max_temp = _response?.tempInfo!.temp_max!.round() ?? 0;
    var feel_temp = _response?.tempInfo!.feel_like!.round() ?? 0;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 80,
              ),
              const Heading(), // Head app bar
              if (_response != null)
                Column(
                  children: [
                    //Weather ICON
                    Image.network(_response!.iconURL),
                    Text(
                      '$temp °C',
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
                    const SizedBox(
                      height: 30,
                    ),
                    const Divider(),
                    moreInformation(
                      '$min_temp',
                      '$max_temp',
                      '${_response!.tempInfo!.humidity}',
                      '$feel_temp',
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

              const SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: _search,
                      child: const Text("Current Weather"),
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
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    const ChangePassword())));
                      },
                      child: const Text(
                        "Change Password",
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
                      onPressed: () {
                        auth.signOut().then((value) =>
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen())));
                      },
                      child: const Text(
                        "Logout",
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
