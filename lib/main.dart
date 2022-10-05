import 'package:flutter/material.dart';
import 'package:weather_app/model/model.dart';
import 'package:weather_app/service/data_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _latTextController = TextEditingController();
  final _lonTextController = TextEditingController();
  final _dataService = dataService();

  WeatherResponse? _response;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                  Text(
                    '${_response!.weatherInfo!.description}',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    child: TextField(
                      controller: _latTextController,
                      decoration: InputDecoration(labelText: 'Latitude'),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 150,
                    child: TextField(
                      controller: _lonTextController,
                      decoration: InputDecoration(labelText: 'Lontitude'),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              child: ElevatedButton(
                onPressed: _search,
                child: Text("Search"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _search() async {
    final response = await _dataService.getWeather(
        _latTextController.text, _lonTextController.text);
    setState(() {
      _response = response;
    });
  }
}
