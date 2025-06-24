
import 'package:flutter/material.dart';
import 'package:perfitir/services/base_screen.dart';
import 'routine_follower.dart';
import 'package:perfitir/services/routine_service.dart'; // Importamos el servicio

/// Modelo simple para representar un ejercicio con nombre, imagen y descripción.
class SimpleExercise {
  final String name, imagePath, description;
  SimpleExercise(this.name, this.imagePath, this.description);
}

/// Pantalla para seleccionar una rutina.
class RoutineCreator extends StatelessWidget {
  const RoutineCreator({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de ejercicios disponibles para seleccionar.
    final exercises = [
      SimpleExercise('Sentadillas', 'assets/images/rutinas/sentadillas.png', 'Espalda recta, baja a 90°.'),
      SimpleExercise('Flexiones', 'assets/images/rutinas/flexiones.png', 'Cuerpo recto, baja el pecho.'),
      SimpleExercise('Plancha', 'assets/images/rutinas/plancha.png', 'Contrae abdomen y mantén postura.'),
    ];

    return BaseScreen(
      title: 'Selecciona Rutina',
      child: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (c, i) {
          final e = exercises[i];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: Image.asset(e.imagePath, width: 50, height: 50, fit: BoxFit.cover),
              title: Text(e.name),
              subtitle: Text(e.description),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final rutina = exercises
              .map((e) => FollowerExercise(e.name, e.description, e.imagePath))
              .toList();

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RoutineFollower(exercises: rutina),
            ),
          );
        },
        icon: const Icon(Icons.play_arrow),
        label: const Text('Iniciar'),
      ),
    );
  }
}
