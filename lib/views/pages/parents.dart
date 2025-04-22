import 'package:flutter/material.dart';
import 'enfants.dart';
import 'activites.dart';
import 'parents.dart';
import 'repas.dart';
import 'enseignants.dart';

class ParentsPage extends StatefulWidget {
  const ParentsPage({super.key});

  @override
  State<ParentsPage> createState() => _ParentsPageState();
}

class _ParentsPageState extends State<ParentsPage> {
  List<Map<String, dynamic>> parents = [
    {"nom": "Marie Dupont", "telephone": "0601020304", "email": "marie@gmail.com", "emoji": "👩‍🍼"},
    {"nom": "Ali Ben", "telephone": "0611223344", "email": "ali.ben@example.com", "emoji": "👨‍👦"},
    {"nom": "Sophie Martin", "telephone": "0655667788", "email": "sophie@gmail.com", "emoji": "👩‍👧"},
  ];

  void _showForm({Map<String, dynamic>? parent, int? index}) {
    final nomController = TextEditingController(text: parent?["nom"] ?? "");
    final telephoneController = TextEditingController(text: parent?["telephone"] ?? "");
    final emailController = TextEditingController(text: parent?["email"] ?? "");
    final emojiController = TextEditingController(text: parent?["emoji"] ?? "");

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(index == null ? "Ajouter un parent" : "Modifier le parent"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: nomController, decoration: const InputDecoration(labelText: "Nom")),
              TextField(controller: telephoneController, decoration: const InputDecoration(labelText: "Téléphone")),
              TextField(controller: emailController, decoration: const InputDecoration(labelText: "Email")),
              TextField(controller: emojiController, decoration: const InputDecoration(labelText: "Emoji")),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Annuler")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
            onPressed: () {
              final nouveauParent = {
                "nom": nomController.text,
                "telephone": telephoneController.text,
                "email": emailController.text,
                "emoji": emojiController.text.isNotEmpty ? emojiController.text : "👨‍👩‍👧‍👦",
              };

              setState(() {
                if (index == null) {
                  parents.add(nouveauParent);
                } else {
                  parents[index] = nouveauParent;
                }
              });

              Navigator.pop(context);
            },
            child: const Text("Enregistrer"),
          ),
        ],
      ),
    );
  }

  void _supprimerParent(int index) {
    setState(() {
      parents.removeAt(index);
    });
  }

  Widget _buildParentCard(int index) {
    final p = parents[index];
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        leading: CircleAvatar(radius: 24, child: Text(p["emoji"], style: const TextStyle(fontSize: 24))),
        title: Text(p["nom"], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        subtitle: Text("Téléphone : ${p["telephone"]}\nEmail : ${p["email"]}"),
        isThreeLine: true,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: const Icon(Icons.edit, color: Colors.orange), onPressed: () => _showForm(parent: p, index: index)),
            IconButton(icon: const Icon(Icons.delete, color: Colors.redAccent), onPressed: () => _supprimerParent(index)),
          ],
        ),
      ),
    );
  }

  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
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
        title: const Text("Parents", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () => _showMenu(context)),
      ),
      body: parents.isEmpty
          ? const Center(
              child: Text(
                "Aucun parent enregistré.\nCliquez sur + pour en ajouter.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: parents.length,
              itemBuilder: (context, index) => _buildParentCard(index),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        onPressed: () => _showForm(),
        tooltip: 'Ajouter un parent',
        child: const Icon(Icons.add),
      ),
    );
  }
}
