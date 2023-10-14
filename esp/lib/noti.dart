import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  void navigateToNotificationScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotificationSection()),
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

    if (title == 'Find Doctor' || title == 'Social Group' || title == 'AI Chatbot' || title == 'Notifications') {
      return GestureDetector(
        onTap: title == 'AI Chatbot'
            ? navigateToChatScreen
            : title == 'Find Doctor'
                ? navigateToDoctorProfileScreen
                : title == 'Notifications'
                    ? navigateToNotificationScreen
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
                  itemDashboard('Notifications', CupertinoIcons.bell, Colors.pinkAccent, 0),
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

// ... (Your existing code remains the same)

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

// ... (Your existing code remains the same)

class NotificationSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: NotificationsList(),
    );
  }
}

class NotificationsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        NotificationItem(
          title: 'Heartbeat Alert',
          time: '10:15 AM',
          description: 'Your heartbeat rate has changed significantly.',
          icon: Icons.favorite,
          color: Colors.red,
        ),
        NotificationItem(
          title: 'Fall Detected',
          time: '11:30 AM',
          description: 'A fall has been detected. Please confirm your status.',
          icon: Icons.person,
          color: Colors.orange,
        ),
        NotificationItem(
          title: 'Temperature Alert',
          time: '01:45 PM',
          description: 'Your body temperature is above the normal range.',
          icon: Icons.thermostat,
          color: Colors.yellow,
        ),
        NotificationItem(
          title: 'Step Count Reminder',
          time: '03:30 PM',
          description: 'You need 100 more steps to reach your daily goal.',
          icon: Icons.directions_run,
          color: Colors.green,
        ),
        NotificationItem(
          title: 'Medication Reminder',
          time: '05:00 PM',
          description: 'It\'s time to take your daily medication.',
          icon: Icons.medical_services,
          color: Colors.blue,
        ),
        NotificationItem(
          title: 'Appointment Reminder',
          time: '06:30 PM',
          description: 'Your doctor appointment is scheduled for tomorrow.',
          icon: Icons.calendar_today,
          color: Colors.purple,
        ),
        NotificationItem(
          title: 'Exercise Reminder',
          time: '07:45 PM',
          description: 'Time for your daily exercise routine.',
          icon: Icons.directions_walk,
          color: Colors.pink,
        ),
      ],
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String title;
  final String time;
  final String description;
  final IconData icon;
  final Color color;

  NotificationItem({
    required this.title,
    required this.time,
    required this.description,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              time,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(description),
          ],
        ),
        onTap: () {
          // Implement action when a notification is tapped
        },
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

class Exercise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise'),
      ),
      body: Center(
        child: Text('Exercise Screen'),
      ),
    );
  }
}
