import 'package:flutter/material.dart';

class ChallengeCard extends StatelessWidget {
  final Map challenge;
  ChallengeCard(this.challenge);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(challenge['title'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(height: 5),
                Text(challenge['desc'], style: TextStyle(fontSize: 13)),
              ],
            ),
          ),
          SizedBox(width: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(challenge['image'], height: 90, width: 90, fit: BoxFit.cover),
          )
        ],
      ),
    );
  }
}
