import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String sensorData = 'Fetching data...';

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://10.0.13.62'));
    if (response.statusCode == 200) {
      setState(() {
        sensorData = response.body;
      });
    } else {
      setState(() {
        sensorData = 'Failed to fetch data';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (timer) {
      fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Sensor Data'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(sensorData),
              ElevatedButton(
                onPressed: () {
                  fetchData();
                  setState(() {}); // Force the rebuild of the widget tree
                },
                child: Text('Refresh Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
