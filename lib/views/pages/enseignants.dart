import 'package:flutter/material.dart';
import 'enfants.dart';
import 'activites.dart';
import 'parents.dart';
import 'repas.dart';
import 'enseignants.dart'; // Auto-importé pour permettre le retour sur cette page depuis le menu

class EnseignantsPage extends StatelessWidget {
  const EnseignantsPage({super.key});

  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return ListView(
          shrinkWrap: true,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Menu",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            _buildMenuItem(context, Icons.child_care, "Enfants"),
            _buildMenuItem(context, Icons.palette, "Activités"),
            _buildMenuItem(context, Icons.people, "Parents"),
            _buildMenuItem(context, Icons.restaurant_menu, "Repas"),
            _buildMenuItem(context, Icons.school, "Enseignants"),
          ],
        );
      },
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title) {
    final Map<String, Widget> pageRoutes = {
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
        Navigator.pop(context); // Ferme le menu
        final Widget? page = pageRoutes[title];
        if (page != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 4,
        title: const Text(
          "Enseignants",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
