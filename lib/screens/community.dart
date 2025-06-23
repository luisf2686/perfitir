import 'package:flutter/material.dart';
import '../challenge_card.dart';
import '../icon_text.dart';
import 'package:perfitir/services/base_screen.dart';


class CommunityScreen extends StatelessWidget {
  
  final challenges = [
    {
      'title': 'Reto En Bicicleta',
      'desc': 'Participa en sesiones intensas de ciclismo para mejorar tu resistencia.',
      'image': 'assets/images/bike.png',
    },
    {
      'title': 'Power Squat',
      'desc': 'Fortalece tus piernas y glúteos con sentadillas intensas.',
      'image': 'assets/images/squat.png',
    },
    {
      'title': 'Press Leg Ultimate',
      'desc': 'Ejercicio de tren inferior ideal para fuerza y tono.',
      'image': 'assets/images/pressleg.png',
    },
    {
      'title': 'Cycling',
      'desc': 'Sesiones diseñadas para mejorar tu capacidad pulmonar.',
      'image': 'assets/images/cycling.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset('assets/Logo_Perfitir.png', height: 50)),
            SizedBox(height: 10),
            Text('Foro', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      CircleAvatar(backgroundImage: AssetImage('assets/images/user.png')),
                      SizedBox(width: 10),
                      Text('Ana', style: TextStyle(fontWeight: FontWeight.bold)),
                    ]),
                    SizedBox(height: 8),
                    Text('Lorem ipsum dolor sit amet consectetur.'),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        IconText(icon: Icons.star, label: '30,254'),
                        IconText(icon: Icons.comment, label: '12,254'),
                        IconText(icon: Icons.remove_red_eye, label: '1,254'),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Retos Y Competencias', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ...challenges.map((challenge) => ChallengeCard(challenge)).toList(),
          ],
        ),
      ),
    );
  }
}
