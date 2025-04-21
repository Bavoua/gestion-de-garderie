import 'package:flutter/material.dart';
import 'pages/enfants.dart';
import 'pages/activites.dart';
import 'pages/parents.dart';
import 'pages/repas.dart';
import 'pages/enseignants.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  Widget _buildMenuButton(BuildContext context, IconData icon, String label, Widget destination) {
    return InkWell(
      onTap: () => _navigateTo(context, destination),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.lightBlue.shade50,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 30, color: Colors.lightBlue),
            const SizedBox(width: 16),
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 4,
        title: const Text(
          'Accueil',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            const Text(
              "Bienvenue 👋",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Choisissez une section pour continuer",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 30),
            _buildMenuButton(context, Icons.child_care, "Enfants", const EnfantsPage()),
            _buildMenuButton(context, Icons.palette, "Activités", const ActivitesPage()),
            _buildMenuButton(context, Icons.people, "Parents", const ParentsPage()),
            _buildMenuButton(context, Icons.restaurant_menu, "Repas", const RepasPage()),
            _buildMenuButton(context, Icons.school, "Enseignants", const EnseignantsPage()),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
