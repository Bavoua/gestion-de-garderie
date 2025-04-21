import 'package:flutter/material.dart';

class ParentsPage extends StatelessWidget {
  const ParentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Parents"),
        backgroundColor: Colors.lightBlue,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            "Bienvenue dans la section Parents !\n\n"
            "Vous pouvez consulter ici les informations relatives aux parents des enfants inscrits.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
