import 'package:flutter/material.dart';
import 'package:perfitir/colores.dart';
import 'package:perfitir/screens/seguimiento_progreso';
import 'screens/exercise_library.dart' as lib;
import 'screens/community.dart';
import 'screens/routine_creator.dart';
import 'screens/routine_manager.dart';
import 'screens/routine_follower.dart';
import 'screens/rutina_semanal.dart';
import 'screens/routine_entry_point.dart'; // Importamos el entry point con lógica de rutina
import 'package:perfitir/services/base_screen.dart';
import 'package:perfitir/services/user_service.dart';

void main() => runApp(const PerfitirApp());

class PerfitirApp extends StatelessWidget {
  const PerfitirApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Perfitir',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: ColoresPerfitir.primario,
        appBarTheme: AppBarTheme(
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          backgroundColor: ColoresPerfitir.primario,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.indigo[900],
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white60,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: ColoresPerfitir.primario,
          primary: ColoresPerfitir.primario,
          secondary: ColoresPerfitir.secundario,
        ),
        scaffoldBackgroundColor: ColoresPerfitir.fondo,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const PantallaInicio(),
        '/welcome': (_) => const MainNavigation(),
        '/login': (_) => const PantallaInicioSesion(),
        '/register': (_) => const PantallaRegistro(),
      },
    );
  }
}

class PantallaInicio extends StatelessWidget {
  const PantallaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/Logo_Perfitir.png', width: 180),
            const SizedBox(height: 24),
            const Text(
              'Activa tu mejor versión',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Registrarse', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/login'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo[900],
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Iniciar Sesión', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PantallaRegistro extends StatefulWidget {
  const PantallaRegistro({super.key});

  @override
  _PantallaRegistroState createState() => _PantallaRegistroState();
}

class _PantallaRegistroState extends State<PantallaRegistro> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String mensaje = '';

  void registrar() async {
    final email = emailController.text.trim();
    final pass = passwordController.text;

    if (await UserService.registerUser(email, pass)) {
      setState(() => mensaje = 'Registrado correctamente');
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      setState(() => mensaje = 'Usuario ya existe');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Correo')),
          TextField(controller: passwordController, obscureText: true, decoration: const InputDecoration(labelText: 'Contraseña')),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: registrar, child: const Text('Registrarse')),
          const SizedBox(height: 10),
          Text(mensaje),
        ]),
      ),
    );
  }
}

class PantallaInicioSesion extends StatefulWidget {
  const PantallaInicioSesion({super.key});

  @override
  _PantallaInicioSesionState createState() => _PantallaInicioSesionState();
}

class _PantallaInicioSesionState extends State<PantallaInicioSesion> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String mensaje = '';

  void login() async {
    final email = emailController.text.trim();
    final pass = passwordController.text;

    if (await UserService.loginUser(email, pass)) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MainNavigation()),
        (route) => false,
      );
    } else {
      setState(() => mensaje = 'Usuario o contraseña incorrectos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar Sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Correo')),
          TextField(controller: passwordController, obscureText: true, decoration: const InputDecoration(labelText: 'Contraseña')),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: login, child: const Text('Iniciar Sesión')),
          const SizedBox(height: 10),
          Text(mensaje),
        ]),
      ),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  MainNavigationState createState() => MainNavigationState();
}

class MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 1;

  // Lista de pantallas navegables desde el menú inferior.
  final List<Widget> _screens = [
    RoutineEntryPoint(), // ← Progreso: verifica si hay rutina y redirige si es necesario
    const RutinaSemanalScreen(),
    const RoutineCreator(),
    const SeguimientoProgreso(),
    CommunityScreen()
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Evita que se regrese al login con el botón de atrás
      child: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onTabTapped,
          selectedItemColor: Colors.grey,
          unselectedItemColor: Colors.black,
          unselectedLabelStyle: const TextStyle(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'Progreso'),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Rutina'),
            BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Entrenar'),
            BottomNavigationBarItem(icon: Icon(Icons.local_fire_department), label: 'Indicadores'),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Comunidad'),
          ],
        ),
      ),
    );
  }
}
