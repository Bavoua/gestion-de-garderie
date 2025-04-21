import 'package:flutter/material.dart';
import 'enfants.dart';
import 'activites.dart';
import 'parents.dart';
import 'repas.dart';
import 'enseignants.dart';

class ActivitesPage extends StatelessWidget {
  const ActivitesPage({super.key});

  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => ListView(
        shrinkWrap: true,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text("Menu", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ),
          _buildMenuItem(context, Icons.child_care, "Enfants"),
          _buildMenuItem(context, Icons.palette, "Activités"),
          _buildMenuItem(context, Icons.people, "Parents"),
          _buildMenuItem(context, Icons.restaurant_menu, "Repas"),
          _buildMenuItem(context, Icons.school, "Enseignants"),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title) {
    final pages = {
      "Enfants": const EnfantsPage(),
      "Activités": const ActivitesPage(),
      "Parents": const ParentsPage(),
      "Repas": const RepasPage(),
      "Enseignants": const EnseignantsPage(),
    };

    return ListTile(
      leading: Icon(icon, color: Colors.lightBlue),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        final page = pages[title];
        if (page != null) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text("Activités", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _showMenu(context),
        ),
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
