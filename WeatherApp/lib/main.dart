import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(
      MyApp(),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://media.beliefnet.com/~/media/photos/stock/earth_from_space.jpg'),
                fit: BoxFit.cover),
          ),
        ),
        title: Text('THE LIVE APP',
            style: TextStyle(color: Colors.yellowAccent, fontSize: 15)),
        backgroundColor: Colors.orangeAccent[400],
      ),
      body: Container(
          decoration: BoxDecoration(
            color: Colors.tealAccent,
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4), BlendMode.dstATop),
                image: NetworkImage(
                    'https://images.fineartamerica.com/images-medium-large-5/old-king-beach-photography-by-juances.jpg'),
                fit: BoxFit.cover),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Weather And Corona Updates',
                    style: TextStyle(
                        fontSize: 28, color: Colors.lightGreenAccent)),
                ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Weather())),
                    child: Text('Weather')),
                ElevatedButton(
                  onPressed: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Second())),
                  child: Text('Corona Meter'),
                )
              ])),
      bottomNavigationBar: BottomAppBar(
        child: Text(
          '          @ Copyright 2021 to Rocker Apps ',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        color: Colors.blueGrey,
      ),
    );
  }
}

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: Text(
                  "Weather",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontStyle: FontStyle.normal),
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.pink[100],
              image: DecorationImage(
                image: NetworkImage(
                    'https://technicalpuruji.com/wp-content/uploads/2019/06/website-background-images-light-color-background-images-for-websites-040.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            selectedTileColor: Colors.cyan,
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MyApp()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings_system_daydream_outlined),
            title: Text('Weather'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Weather()));
            },
          ),
          ListTile(
            leading: Icon(Icons.health_and_safety),
            title: Text('Corona Meter'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Second()));
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Exit'),
            onTap: () => {SystemNavigator.pop()},
          ),
        ],
      ),
    );
  }
}

class Second extends StatefulWidget {
  @override
  _SecondScreen createState() => _SecondScreen();
}

class _SecondScreen extends State<Second> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Corona Meter",
              style: TextStyle(color: Colors.tealAccent, fontSize: 15)),
          backgroundColor: Colors.blueAccent[100],
        ),
        drawer: SideDrawer(),
        body: WebView(
          onWebResourceError: (WebResourceError webviewerrr) {
            print("We will recover soon. Sorry for the inconvenience");
          },
          initialUrl: "https://www.mohfw.gov.in/",
          javascriptMode: JavascriptMode.unrestricted,
          onPageFinished: (String url) {
            print('Page finished loading:');
          },
        ));
  }
}

class DataService {
  Future<WeatherResponse> getWeather(String city) async {
    // api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

    final queryParameters = {
      'q': city,
      'appid': 'Your app ID',
      'lang': 'en',
      'units': 'metric'
    };

    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameters);

    final response = await http.get(uri);

    print(response.body);
    final json = jsonDecode(response.body);
    return WeatherResponse.fromJson(json);
  }
}

class Weather extends StatefulWidget {
  @override
  _Weather createState() => _Weather();
}

class _Weather extends State<Weather> {
  final _cityTextController = TextEditingController();

  WeatherResponse _response;
  final _dataService = DataService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              color: Colors.tealAccent,
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4), BlendMode.dstATop),
                  image: NetworkImage(
                      'https://i.pinimg.com/originals/41/e0/fe/41e0fe13c9558fcb88a1d7b88b622c27.jpg'),
                  fit: BoxFit.cover),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_response != null)
                  Column(
                    children: [
                      Image.network(_response.iconUrl),
                      Text(
                        '${(_response.tempInfo.temperature)}°',
                        style: TextStyle(fontSize: 40),
                      ),
                      Text(
                        '${(_response.weatherInfo.description)}',
                        style: TextStyle(fontSize: 30, color: Colors.black87),
                      ),
                      Text('Max Temperature: ${(_response.tempInfo.max_temp)}',
                          style:
                              TextStyle(fontSize: 20, color: Colors.blue[900])),
                      Text('Min Temperature: ${(_response.tempInfo.min_temp)}',
                          style:
                              TextStyle(fontSize: 20, color: Colors.blue[900])),
                      Text('Humidity: ${(_response.tempInfo.humidity)}',
                          style: TextStyle(fontSize: 20, color: Colors.brown)),
                    ],
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: SizedBox(
                    ///width: 150,
                    child: TextField(
                      controller: _cityTextController,
                      decoration: InputDecoration(
                          icon: Icon(Icons.contactless_sharp),
                          hintText: 'Enter City',
                          fillColor: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                ElevatedButton(onPressed: _search, child: Text('Search'))
              ],
            ),
          ),
        ));
  }

  void _search() async {
    final response = await _dataService.getWeather(_cityTextController.text);

    setState(() => _response = response);
  }
}

class WeatherInfo {
  final String description;
  final String icon;

  WeatherInfo({this.description, this.icon});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final description = json['description'];
    final icon = json['icon'];
    return WeatherInfo(description: description, icon: icon);
  }
}

class TemperatureInfo {
  final double temperature;
  final double min_temp;
  final double max_temp;
  final int humidity;
  TemperatureInfo(
      {this.temperature, this.min_temp, this.max_temp, this.humidity});

  factory TemperatureInfo.fromJson(Map<String, dynamic> json) {
    final min_temp = json['temp_min'];
    final max_temp = json['temp_max'];
    final humidity = json['humidity'];
    final temperature = json['temp'];
    return TemperatureInfo(
        temperature: temperature,
        max_temp: max_temp,
        min_temp: min_temp,
        humidity: humidity);
  }
}

class WeatherResponse {
  final String cityName;
  final TemperatureInfo tempInfo, max_temp, min_temp, humidity;
  final WeatherInfo weatherInfo;

  String get iconUrl {
    return 'https://openweathermap.org/img/wn/${weatherInfo.icon}@2x.png';
  }

  WeatherResponse(
      {this.cityName,
      this.tempInfo,
      this.weatherInfo,
      this.humidity,
      this.min_temp,
      this.max_temp});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];

    final tempInfoJson = json['main'];
    final tempInfo = TemperatureInfo.fromJson(tempInfoJson);
    final min_temp = TemperatureInfo.fromJson(json['main']);
    final max_temp = TemperatureInfo.fromJson(json['main']);
    final humidity = TemperatureInfo.fromJson(json['main']);
    final weatherInfoJson = json['weather'][0];
    final weatherInfo = WeatherInfo.fromJson(weatherInfoJson);

    return WeatherResponse(
      cityName: cityName,
      tempInfo: tempInfo,
      max_temp: max_temp,
      min_temp: min_temp,
      humidity: humidity,
      weatherInfo: weatherInfo,
    );
  }
}
