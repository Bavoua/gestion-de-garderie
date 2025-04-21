import 'package:flutter/material.dart';

class RepasPage extends StatelessWidget {
  const RepasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Repas"),
        backgroundColor: Colors.lightBlue,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            "Bienvenue dans la section Repas !\n\n"
            "Découvrez les menus, les régimes alimentaires et les horaires de repas.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
