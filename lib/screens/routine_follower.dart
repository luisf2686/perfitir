import 'dart:async';
import 'package:flutter/material.dart';
import 'package:perfitir/services/base_screen.dart';

class FollowerExercise {
  final String name, description, imageUrl;
  FollowerExercise(this.name, this.description, this.imageUrl);
}

class RoutineFollower extends StatefulWidget {
  final List<FollowerExercise> exercises;
  const RoutineFollower({super.key, required this.exercises});

  @override
  State<RoutineFollower> createState() => _RoutineFollowerState();
}

class _RoutineFollowerState extends State<RoutineFollower> {
  int idx = 0, timerSec = 30;
  double prog = 0;
  Timer? _t;
  bool mostrarBotonFinal = false;

  @override
  void initState() {
    super.initState();
    iniciarTemporizador();
  }

  void iniciarTemporizador() {
    _t?.cancel();
    timerSec = 30;
    prog = 0;
    _t = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        if (timerSec > 0) {
          timerSec--;
          prog += 1 / 30;
        } else {
          if (idx < widget.exercises.length - 1) {
            idx++;
            iniciarTemporizador();
          } else {
            // Último ejercicio, mostrar botón final
            mostrarBotonFinal = true;
            _t?.cancel();
          }
        }
      });
    });
  }

  void siguiente() {
    if (idx < widget.exercises.length - 1) {
      setState(() => idx++);
      iniciarTemporizador();
    }
  }

  @override
  void dispose() {
    _t?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final e = widget.exercises[idx];
    return BaseScreen(
      title: e.name,
      child: Column(
        children: [
          LinearProgressIndicator(value: prog),
          const SizedBox(height: 12),
          Text(e.description, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 12),
          Image.asset(e.imageUrl, height: 180),
          const SizedBox(height: 12),
          Text('Tiempo: $timerSec s'),
          const Spacer(),

          // Si estamos en el último ejercicio y tiempo llegó a 0
          if (mostrarBotonFinal)
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil('/welcome', (route) => false);
              },
              child: const Text('Volver'),
            )
          else
            ElevatedButton(onPressed: siguiente, child: const Text('Siguiente')),
        ],
      ),
    );
  }
}
