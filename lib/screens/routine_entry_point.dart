
import 'package:flutter/material.dart';
import 'package:perfitir/screens/routine_creator.dart';
import 'package:perfitir/screens/routine_follower.dart';
import 'package:perfitir/services/routine_service.dart';

/// Esta pantalla verifica si hay una rutina seleccionada y redirige según corresponda.
class RoutineEntryPoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Si no hay rutina, redirige automáticamente a la pantalla de selección.
    if (!RoutineService.hasRoutine()) {
      Future.microtask(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Por favor selecciona una rutina")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const RoutineCreator()),
        );
      });

      // Evita que se muestre una pantalla en blanco mientras redirige
      return const SizedBox.shrink();
    }

    // Si hay rutina seleccionada, muestra la pantalla de seguimiento
    return RoutineFollower(exercises: RoutineService.getRoutine()!);
  }
}
