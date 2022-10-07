import 'package:flutter/material.dart';
import 'package:weather_app/screen/login.dart';
import 'package:weather_app/screen/register.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Application',
      home: Scaffold(
        //extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,

        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            "Weather Application",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 25,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),

        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                _buildStack(),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const Register();
                      }));
                    },
                    icon: const Icon(Icons.add),
                    label: const Text(
                      "Create Account",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Login();
                        }));
                      },
                      icon: const Icon(Icons.login),
                      label: const Text(
                        "sign in",
                        style: TextStyle(fontSize: 20),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildStack() {
  return Stack(
    alignment: const Alignment(0.6, 0.6),
    children: const [
      CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: AssetImage('images/W2.png'),
        radius: 75,
      ),
    ],
  );
}
