import 'package:flutter/material.dart';

class Exercise {
  final String name;
  final String description;
  final String imageUrl;
  final String videoUrl;
  final String muscleGroup;
  final String equipment;
  final String difficulty;

  Exercise({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.videoUrl,
    required this.muscleGroup,
    required this.equipment,
    required this.difficulty,
  });
}

class ExerciseLibrary extends StatefulWidget {
  @override
  _ExerciseLibraryState createState() => _ExerciseLibraryState();
}

class _ExerciseLibraryState extends State<ExerciseLibrary> {
  List<Exercise> exercises = [
    Exercise(
      name: 'Push Up',
      description: 'A basic push-up exercise.',
      imageUrl: 'assets/images/push_up.png',
      videoUrl: 'https://example.com/push_up_video',
      muscleGroup: 'Chest',
      equipment: 'None',
      difficulty: 'Beginner',
    ),
    // Add more exercises here
  ];

  String searchQuery = '';
  String selectedMuscleGroup = 'All';
  String selectedEquipment = 'All';
  String selectedDifficulty = 'All';

  @override
  Widget build(BuildContext context) {
    List<Exercise> filteredExercises = exercises.where((exercise) {
      return (exercise.name.toLowerCase().contains(searchQuery.toLowerCase()) || searchQuery.isEmpty) &&
             (exercise.muscleGroup == selectedMuscleGroup || selectedMuscleGroup == 'All') &&
             (exercise.equipment == selectedEquipment || selectedEquipment == 'All') &&
             (exercise.difficulty == selectedDifficulty || selectedDifficulty == 'All');
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise Library'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          // Add dropdowns for filtering
          Expanded(
            child: ListView.builder(
              itemCount: filteredExercises.length,
              itemBuilder: (context, index) {
                final exercise = filteredExercises[index];
                return ListTile(
                  leading: Image.asset(exercise.imageUrl),
                  title: Text(exercise.name),
                  subtitle: Text(exercise.description),
                  onTap: () {
                    // Navigate to exercise details
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 