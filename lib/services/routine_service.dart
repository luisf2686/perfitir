
// lib/services/routine_service.dart
import '../screens/routine_follower.dart';

/// Servicio para almacenar y recuperar la rutina seleccionada en la aplicación.
class RoutineService {
  static List<FollowerExercise>? selectedRoutine;

  /// Guarda la rutina seleccionada para usarla luego.
  static void setRoutine(List<FollowerExercise> routine) {
    selectedRoutine = routine;
  }

  /// Recupera la rutina seleccionada.
  static List<FollowerExercise>? getRoutine() {
    return selectedRoutine;
  }

  /// Limpia la rutina seleccionada.
  static void clearRoutine() {
    selectedRoutine = null;
  }

  /// Verifica si hay una rutina seleccionada.
  static bool hasRoutine() {
    return selectedRoutine != null && selectedRoutine!.isNotEmpty;
  }
}
