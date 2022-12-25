import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_api/screens/main_screen.dart';
import 'package:weather_api/utils/location.dart';
import 'package:weather_api/utils/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late LocationHelper locationData;
  Future<void> getLocationData() async {
    locationData = LocationHelper();
    await locationData.getCurrentLocation();

    if (locationData.latitude == null || locationData.longitude == null) {
      print("location information has not been reached");
    } else {
      print("latitide = " + locationData.latitude.toString());
      print("longitude = " + locationData.longitude.toString());
    }
  }

  void getWeatherData() async {
    await getLocationData(); // önce getLocationData fonksyonunu bi beklesin.
    WeatherData weatherData = WeatherData(locationData);
    await weatherData.getCurrentTempurature();
    if (weatherData.currentTempurature == null ||
        weatherData.currentCondition == null) {
      print("API can not provide tempurature or condition");
    }

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return MainScreen(
        weatherData: weatherData,
      );
    }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeatherData();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.red, Colors.blue],
      )),
      child: Center(
        child: SpinKitCubeGrid(
          color: Colors.white,
          size: 180.0,
          duration: Duration(milliseconds: 1200),
        ),
      ),
    ));
  }
}
