import 'package:flutter/material.dart';
import 'package:perfitir/colores.dart';

class BaseScreen extends StatelessWidget {
  final String title;
  final Widget child;
  final FloatingActionButton? floatingActionButton;

  const BaseScreen({
    super.key,
    required this.title,
    required this.child,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(color: Colors.white)),
        backgroundColor: ColoresPerfitir.primario,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
