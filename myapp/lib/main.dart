import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:myapp/main2.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int heartValue = 10;
  int spo2Value = 10;
  int fallDetectionValue = 10;
  int heartRateValue = 10;
  int stepsCountValue = 5000;
  double temperatureValue = 98.6;

  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        heartValue = heartValue > 1 ? heartValue - 1 : 10;
        spo2Value = spo2Value > 1 ? spo2Value - 1 : 10;
        fallDetectionValue = fallDetectionValue > 1 ? fallDetectionValue - 1 : 10;
        heartRateValue = heartRateValue > 1 ? heartRateValue - 1 : 10;
        stepsCountValue += 10;
        temperatureValue += 0.1;
      });
    });
  }

  void navigateToChatScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatScreen()),
    );
  }

  void navigateToDoctorProfileScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DoctorProfile()),
    );
  }

  void navigateToExerciseScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Exercise()),
    );
  }

  Widget itemDashboard(String title, IconData iconData, Color background, dynamic value) {
    IconData updatedIcon;
    switch (title) {
      case 'Heart':
        updatedIcon = _getHeartIcon(value);
        break;
      case 'SpO2 Logo':
        updatedIcon = _getSpO2Icon(value);
        break;
      case 'Fall Detection':
        updatedIcon = _getFallDetectionIcon(value);
        break;
      case 'Heart Rate':
        updatedIcon = _getHeartRateIcon(value);
        break;
      case 'Steps Count':
        updatedIcon = Icons.directions_walk;
        break;
      case 'Temperature':
        updatedIcon = Icons.ac_unit;
        break;
      case 'Medicine':
        updatedIcon = Icons.medical_services;
        break;
      case 'Exercise':
        updatedIcon = Icons.directions_run;
        break;
      default:
        updatedIcon = iconData;
    }

    if (title == 'Find Doctor' ||
        title == 'Social Group' ||
        title == 'AI Chatbot' ||
        title == 'Notification') {
      return GestureDetector(
        onTap: title == 'AI Chatbot'
            ? navigateToChatScreen
            : title == 'Find Doctor'
                ? navigateToDoctorProfileScreen
                : null,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 5),
                color: Theme.of(context).primaryColor.withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: background,
                  shape: BoxShape.circle,
                ),
                child: Icon(updatedIcon, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text('$title', style: Theme.of(context).textTheme.subtitle1),
            ],
          ),
        ),
      );
    } else if (title == 'Exercise') {
      return GestureDetector(
        onTap: navigateToExerciseScreen,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 5),
                color: Theme.of(context).primaryColor.withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: background,
                  shape: BoxShape.circle,
                ),
                child: Icon(updatedIcon, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text('$title', style: Theme.of(context).textTheme.subtitle1),
            ],
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: title == 'AI Chatbot' ? navigateToChatScreen : null,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 5),
                color: Theme.of(context).primaryColor.withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: background,
                  shape: BoxShape.circle,
                ),
                child: Icon(updatedIcon, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text('$title: $value', style: Theme.of(context).textTheme.subtitle1),
            ],
          ),
        ),
      );
    }
  }

  IconData _getHeartIcon(int value) {
    return value > 5 ? Icons.favorite : Icons.favorite_border;
  }

  IconData _getSpO2Icon(int value) {
    return value > 5 ? Icons.check_circle : Icons.error;
  }

  IconData _getFallDetectionIcon(int value) {
    return value > 5 ? Icons.warning : Icons.error_outline;
  }

  IconData _getHeartRateIcon(int value) {
    return value > 5 ? Icons.favorite : Icons.favorite_border;
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: Text('Hello Aniket!', style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: Colors.white,
                  )),
                  subtitle: const Text('Good Morning', style: TextStyle(color: Colors.white54)),
                  trailing: const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/dil.jpg'),
                  ),
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(200),
                  )),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 30,
                children: [
                  itemDashboard('Heart', CupertinoIcons.heart, Colors.deepOrange, heartValue),
                  itemDashboard('SpO2 Logo', CupertinoIcons.square_favorites, Colors.green, spo2Value),
                  itemDashboard('Fall Detection', CupertinoIcons.exclamationmark_triangle, Colors.purple, fallDetectionValue),
                  itemDashboard('Heart Rate', CupertinoIcons.heart_fill, Colors.brown, heartRateValue),
                  itemDashboard('Steps Count', Icons.directions_walk, Colors.orange, stepsCountValue),
                  itemDashboard('Temperature', Icons.ac_unit, Colors.red, temperatureValue.toInt()),
                  itemDashboard('Find Doctor', CupertinoIcons.profile_circled, Colors.indigo, 1),
                  itemDashboard('Social Group', CupertinoIcons.group, Colors.teal, 0),
                  itemDashboard('AI Chatbot', CupertinoIcons.chat_bubble_text_fill, Colors.blue, 0),
                  itemDashboard('Notification', CupertinoIcons.bell, Colors.pinkAccent, 0),
                  itemDashboard('Medicine', Icons.medical_services, Colors.yellow, 0),
                  itemDashboard('Exercise', Icons.directions_run, Colors.blue, 0),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];

  Future<void> _sendMessage(String message) async {
    try {
      final apiKey = "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";
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          // Replace 'YOUR_OPENAI_API_KEY' with your actual OpenAI API key
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "system",
              "content": "You are a helpful assistant",
            },
            {
              "role": "user",
              "content": "$message",
            },
            {
              "role": "assistant",
              "content": "How may I assist you today?",
            },
          ],
          "temperature": 1,
          "max_tokens": 256,
          "top_p": 1,
          "frequency_penalty": 0,
          "presence_penalty": 0,
        }),
      );
      print(response.body);
      print(message);

      // Use setState to update the UI with the new message
      setState(() {
        _messages.add('User: $message');

        // Extract and add the assistant's response to the _messages list
        final responseJson = jsonDecode(response.body);
        final assistantResponse = responseJson['choices'][0]['message']['content'];
        _messages.add('Assistant: $assistantResponse');
      });
    } catch (e) {
      // Handle exceptions
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]),
                );
              },
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Type your message',
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    _sendMessage(_controller.text);
                    setState(() {
                      _controller.clear(); // Clear the input field
                    });
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DoctorProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Doctor Profile'),
        ),
        body: DoctorProfileScreen(),
      ),
    );
  }
}

class DoctorProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dr. John Smith',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          const Text(
            'Cardiologist',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            '123 Main Street\nCity, State, ZIP Code',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              const Icon(Icons.phone, color: Colors.blue),
              const SizedBox(width: 8.0),
              const Text(
                '+1 (123) 456-7890',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
