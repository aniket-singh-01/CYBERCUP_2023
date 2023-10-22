import 'package:flutter/material.dart';

void main() {
  runApp(NotificationApp());
}

class NotificationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NotificationSection(),
    );
  }
}

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
        // Add more notification items here
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