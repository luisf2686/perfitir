import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:perfitir/services/base_screen.dart';
import 'package:flutter/services.dart' show rootBundle;

class RutinaSemanalScreen extends StatefulWidget {
  const RutinaSemanalScreen({super.key});

  @override
  State<RutinaSemanalScreen> createState() => _RutinaSemanalScreenState();
}

class _RutinaSemanalScreenState extends State<RutinaSemanalScreen> {
  Map<String, dynamic>? rutina;

  @override
  void initState() {
    super.initState();
    cargarRutina();
  }

  Future<void> cargarRutina() async {
    try {
      final String response = await rootBundle.loadString('assets/data/rutina_semanal.json');
      final data = json.decode(response);
      setState(() {
        rutina = data;
      });
    } catch (e) {
      print("Error cargando rutina: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Rutina Semanal',
      child: rutina == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Image.asset('assets/Logo_Perfitir.png', height: 50)),
                  const SizedBox(height: 10),
                  const Text(
                    'Mi Rutina Semanal',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ...rutina!.entries.map((entry) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      elevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ExpansionTile(
                        title: Text(
                          entry.key.toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        children: List<Widget>.from(entry.value.map<Widget>(
                          (actividad) => ListTile(
                            leading: const Icon(Icons.fitness_center),
                            title: Text(actividad),
                          ),
                        )),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
    );
  }
}
