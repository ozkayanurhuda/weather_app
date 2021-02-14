import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Weather App",
        home: Home(),
      ),
    );

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  Future getWeather() async {
    http.Response response = await http.get(
        "http://api.openweathermap.org/data/2.5/weather?q=İzmir&units=metric&appid=8646973552a0eb895de8ca450a88d564");
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
    });
  }

  ///it runs anything inside that method first
  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2.5,
            width: MediaQuery.of(context).size.width,
            color: Colors.red[400],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 17.0),

                  /// For location
                  child: Text(
                    "Currently in İzmir",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                ///For degree
                Text(
                  temp != null ? temp.toString() + "\u00B0" : "Loading..",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                ///For situation
                Padding(
                  padding: EdgeInsets.only(top: 9.0),
                  child: Text(
                    currently != null ? currently.toString() : "Loading...",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.thermometerHalf,
                      color: Colors.red,
                    ),
                    title: Text(
                      "Temperature",
                      style: TextStyle(
                        letterSpacing: 0.4,
                      ),
                    ),
                    trailing: Text(temp != null
                        ? temp.toString() + "\u00B0"
                        : "Loading..."),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud, color: Colors.blue),
                    title: Text(
                      "Weather",
                      style: TextStyle(
                        letterSpacing: 0.4,
                      ),
                    ),
                    trailing: Text(description != null
                        ? description.toString()
                        : "Loading..."),
                  ),
                  ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.sun,
                      color: Colors.yellow[700],
                    ),
                    title: Text(
                      "Humidity",
                      style: TextStyle(
                        letterSpacing: 0.4,
                      ),
                    ),
                    trailing: Text(humidity != null
                        ? "%" + humidity.toString()
                        : "Loading..."),
                  ),
                  ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.wind,
                      color: Colors.brown,
                    ),
                    title: Text(
                      "Wind Speed",
                      style: TextStyle(
                        letterSpacing: 0.4,
                      ),
                    ),
                    trailing: Text(windSpeed != null
                        ? windSpeed.toString()
                        : "Loading..."),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
