import 'package:flutter/material.dart';

class EnfantsPage extends StatelessWidget {
  const EnfantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enfants"),
        backgroundColor: Colors.lightBlue,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            "Bienvenue dans la section Enfants !\n\n"
            "Vous trouverez ici toutes les informations concernant les enfants inscrits.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
