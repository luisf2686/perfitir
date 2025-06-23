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
  bool done = false;

  @override
  void initState() {
    super.initState();
    resetTimer();
  }

  void resetTimer() {
    _t?.cancel();
    timerSec = 30;
    prog = 0;
    _t = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        if (timerSec > 0) {
          timerSec--;
          prog += 1 / 30;
        } else {
          next();
        }
      });
    });
  }

  void next() {
    if (idx < widget.exercises.length - 1) {
      setState(() => idx++);
      resetTimer();
    } else {
      setState(() => done = true);
      _t?.cancel();
    }
  }

  @override
  void dispose() {
    _t?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext c) {
    if (done) {
      return BaseScreen(
        title: '¡Completado!',
        child: Center(
          child: ElevatedButton(
            onPressed: () => Navigator.pop(c),
            child: const Text('Volver'),
          ),
        ),
      );
    }
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
          ElevatedButton(onPressed: next, child: const Text('Siguiente')),
        ],
      ),
    );
  }
}
