import 'package:flutter/material.dart';

class ActivitesPage extends StatelessWidget {
  const ActivitesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Activités"),
        backgroundColor: Colors.lightBlue,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            "Bienvenue dans la section Activités !\n\n"
            "Cette section présente les activités éducatives et ludiques proposées aux enfants.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
