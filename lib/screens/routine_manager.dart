import 'package:flutter/material.dart';
import 'routine_creator.dart';
import 'routine_follower.dart';
import 'package:perfitir/colores.dart';

class RoutineManager extends StatefulWidget {
  @override
  _RoutineManagerState createState() => _RoutineManagerState();
}

class _RoutineManagerState extends State<RoutineManager> {
  List<Map<String, dynamic>> savedRoutines = [];
  List<Map<String, dynamic>> completedRoutines = [];

  void markRoutineAsCompleted(Map<String, dynamic> routine) {
    setState(() {
      completedRoutines.add(routine);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Routines'),
        backgroundColor: ColoresPerfitir.primario,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: savedRoutines.length,
              itemBuilder: (context, index) {
                final routine = savedRoutines[index];
                return ListTile(
                  title: Text(routine['name'] ?? 'Unnamed Routine', style: TextStyle(color: ColoresPerfitir.textoOscuro)),
                  subtitle: Text('Exercises: ${routine['exercises'].length}', style: TextStyle(color: ColoresPerfitir.textoOscuro)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RoutineFollower(exercises: routine['exercises']),
                      ),
                    ).then((_) {
                      markRoutineAsCompleted(routine);
                    });
                  },
                );
              },
            ),
          ),
          const Divider(),
          const Text('Completed Routines', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColoresPerfitir.textoOscuro)),
          Expanded(
            child: ListView.builder(
              itemCount: completedRoutines.length,
              itemBuilder: (context, index) {
                final routine = completedRoutines[index];
                return ListTile(
                  title: Text(routine['name'] ?? 'Unnamed Routine', style: TextStyle(color: ColoresPerfitir.textoOscuro)),
                  subtitle: Text('Completed on: ${DateTime.now()}', style: TextStyle(color: ColoresPerfitir.textoOscuro)),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RoutineCreator()),
          ).then((newRoutine) {
            if (newRoutine != null) {
              setState(() {
                savedRoutines.add(newRoutine);
              });
            }
          });
        },
        backgroundColor: ColoresPerfitir.secundario,
        child: const Icon(Icons.add, color: ColoresPerfitir.fondo),
      ),
    );
  }
} 