import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherWidget extends StatefulWidget {
  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  List<String> cities = ["Kyiv", "Odesa", "Lviv", "Cherkasy"];
  List<Map<String, String>> weatherDataList = [];

  @override
  void initState() {
    super.initState();
    fetchWeatherForAllCities();
  }

  Future<void> fetchWeatherForAllCities() async {
    for (String city in cities) {
      final response = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$city,UA&appid=819c472bb868fa5e7341c44e838d21d9&units=metric',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          weatherDataList.add({
            'city': city,
            'temperature': "${data['main']['temp'].toStringAsFixed(0)}°C",
            'condition': data['weather'][0]['description'],
            'iconUrl': "http://openweathermap.org/img/w/${data['weather'][0]['icon']}.png",
          });
        });
      } else {
        setState(() {
          weatherDataList.add({
            'city': city,
            'temperature': "Error",
            'condition': "Could not fetch weather",
            'iconUrl': "",
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Погода в містах'),
      ),
      body: ListView.builder(
        itemCount: weatherDataList.length,
        itemBuilder: (context, index) {
          final weather = weatherDataList[index];
          return Card(
            child: ListTile(
              title: Text(weather['city']!),
              subtitle: Text(weather['condition']!),
              leading: weather['iconUrl']!.isNotEmpty
                  ? Image.network(weather['iconUrl']!, width: 50, height: 50)
                  : null,
              trailing: Text(weather['temperature']!),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: WeatherWidget(),
  ));
}
