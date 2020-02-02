import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:clima/services/location.dart';
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location loc = Location();
    await loc.getCurrentLocation();
    print("Pos: ${loc.latitude}, ${loc.longitude}");
  }

  void getData() async {
    http.Response res = await http.get('http://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22');
    if ( res.statusCode == 200 ) {
      var codeData = jsonDecode(res.body);
      double temp = codeData['main']['temp'];
      int condID = codeData['weather'][0]['id'];
      String cityName = codeData['name'];
      print('[${condID}] ${cityName}: ${temp}');
    } else {
      print(res.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
//      body: Center(
//        child: RaisedButton(
//          onPressed: () {
//            getLocation();
//          },
//          child: Text('Get Location'),
//        ),
//      ),
    );
  }
}
