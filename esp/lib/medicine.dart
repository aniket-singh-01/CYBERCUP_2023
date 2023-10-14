import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class DrugLabel {
  final List<String> drugInteractions;

  DrugLabel({required this.drugInteractions});

  factory DrugLabel.fromJson(Map<String, dynamic> json) {
    return DrugLabel(drugInteractions: List.from(json['results'][0]['openfda']['drug_interactions']));
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DrugLabelApp(),
    );
  }
}

class DrugLabelApp extends StatefulWidget {
  @override
  _DrugLabelAppState createState() => _DrugLabelAppState();
}

class _DrugLabelAppState extends State<DrugLabelApp> {
  late Future<DrugLabel> futureDrugLabel;

  @override
  void initState() {
    super.initState();
    futureDrugLabel = fetchDrugLabel();
  }

  Future<DrugLabel> fetchDrugLabel() async {
    final apiKey = "cmZsxgVe8WikYWhBwGQs91rYe48cn5TjNUaQ5gzf";
    final url = Uri.parse('https://api.fda.gov/drug/label.json?api_key=$apiKey&search=drug_interactions:caffeine&limit=5');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data); // Print the response JSON data
      return DrugLabel.fromJson(data);
    } else {
      throw Exception('Failed to load drug label');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drug Label App'),
      ),
      body: Center(
        child: FutureBuilder<DrugLabel>(
          future: futureDrugLabel,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.drugInteractions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data!.drugInteractions[index]),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              return Text("No data found");
            }
          },
        ),
      ),
    );
  }
}
