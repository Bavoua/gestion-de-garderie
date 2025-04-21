import 'package:flutter/material.dart';

class EnseignantsPage extends StatelessWidget {
  const EnseignantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enseignants"),
        backgroundColor: Colors.lightBlue,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            "Bienvenue dans la section Enseignants !\n\n"
            "Consultez les profils des enseignants, leurs matières et leurs rôles.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
