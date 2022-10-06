import 'package:flutter/cupertino.dart';

TextStyle styleFont = const TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: 18,
);

TextStyle styleFont_info = const TextStyle(
  fontSize: 18,
);

Widget moreInformation(
    String temp_min, String temp_max, String humidity, String feel_like) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Min", style: styleFont),
                const SizedBox(
                  height: 10,
                ),
                Text("Max", style: styleFont),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${temp_min} °C", style: styleFont_info),
                const SizedBox(
                  height: 10,
                ),
                Text("${temp_max} °C", style: styleFont_info),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Humidity", style: styleFont),
                const SizedBox(
                  height: 10,
                ),
                Text("Feels like", style: styleFont),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${humidity} %", style: styleFont_info),
                const SizedBox(
                  height: 10,
                ),
                Text("${feel_like} °C", style: styleFont_info),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
