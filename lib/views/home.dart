import 'package:flutter/material.dart';
import 'pages/enfants.dart';
import 'pages/activites.dart';
import 'pages/parents.dart';
import 'pages/repas.dart';
import 'pages/enseignants.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
  // Associe chaque titre à sa page
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
        Navigator.push(
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
          'Accueil',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _showMenu(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.home,
              size: 100,
              color: Colors.lightBlue,
            ),
            const SizedBox(height: 40),
            const Text(
              "Bienvenue à l'accueil !",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              "Nous sommes ravis de vous voir ici. "
              "Explorez l'application pour découvrir toutes ses fonctionnalités !",
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                // Action du bouton ici
              },
              icon: const Icon(Icons.arrow_forward),
              label: const Text("Commencer"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                foregroundColor: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 14,
                ),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
