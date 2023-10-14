import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() {
  runApp(WorkoutApp());
}

class WorkoutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WorkoutScreen(),
    );
  }
}

class WorkoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercises for Elderly Healthcare'),
      ),
      body: ExerciseList(),
    );
  }
}

class ExerciseList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ExerciseCard(
          title: 'Leg Raises',
          description:
              'Sit comfortably in a chair. Slowly lift one leg off the floor, straightening it out in front of you. Hold for a few seconds, then lower it back down. Repeat with the other leg.',
          videoId: 'qvi8aM02_GY',
        ),
        ExerciseCard(
          title: 'Arm Raises',
          description:
              'Sitting upright or standing, lift your arms to the sides until they are shoulder-height. Slowly lower them back down and repeat.',
          videoId: 'JDj-GoBK-cc',
        ),
        ExerciseCard(
          title: 'Shoulder Rolls',
          description:
              'Sit comfortably in a chair. Roll your shoulders in a circular motion, first forward for 10 rotations, then backward for 10 rotations.',
          videoId: 'X7NtgY9kCCM',
        ),
        ExerciseCard(
          title: 'Ankle Flex',
          description:
              'Sit on a chair with your feet flat on the ground. Lift one foot and rotate your ankle in a circular motion, first clockwise for 10 rotations, then counterclockwise for 10 rotations. Repeat with the other foot.',
          videoId: 'e6WugOzgFIM',
        ),
        ExerciseCard(
          title: 'Neck Stretch',
          description:
              'Sitting upright, tilt your head to one side until you feel a stretch on the opposite side of your neck. Hold for a few seconds and then repeat on the other side.',
          videoId: '2NOsE-VPpkE',
        ),
        ExerciseCard(
          title: 'Knee Extension',
          description:
              'Sitting in a chair, straighten one leg out in front of you. Hold for a few seconds and then lower it back down. Repeat with the other leg.',
          videoId: 'VuJZ6dqMf8M',
        ),
      ],
    );
  }
}

class ExerciseCard extends StatelessWidget {
  final String title;
  final String description;
  final String videoId;

  ExerciseCard({required this.title, required this.description, required this.videoId});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(description),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: videoId,
                flags: YoutubePlayerFlags(
                  autoPlay: false,
                  mute: false,
                ),
              ),
              showVideoProgressIndicator: true,
            ),
          ),
        ],
      ),
    );
  }
}
