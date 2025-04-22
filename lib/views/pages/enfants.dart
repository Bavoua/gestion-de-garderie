import 'package:flutter/material.dart';
import 'enfants.dart';
import 'activites.dart';
import 'parents.dart';
import 'repas.dart';
import 'enseignants.dart';

class EnfantsPage extends StatefulWidget {
  const EnfantsPage({super.key});

  @override
  State<EnfantsPage> createState() => _EnfantsPageState();
}

class _EnfantsPageState extends State<EnfantsPage> {
  List<Map<String, dynamic>> enfants = [
    {"nom": "Lina Dupont", "age": 6, "classe": "CP", "avatar": "👧"},
    {"nom": "Ethan Martin", "age": 5, "classe": "GS", "avatar": "👦"},
    {"nom": "Inès Leroy", "age": 7, "classe": "CE1", "avatar": "👧"},
  ];

  void _showForm({Map<String, dynamic>? enfant, int? index}) {
    final nomController = TextEditingController(text: enfant?["nom"] ?? "");
    final ageController = TextEditingController(text: enfant?["age"]?.toString() ?? "");
    final classeController = TextEditingController(text: enfant?["classe"] ?? "");
    final avatarController = TextEditingController(text: enfant?["avatar"] ?? "");

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(index == null ? "Ajouter un enfant" : "Modifier l'enfant"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomController,
                decoration: const InputDecoration(labelText: "Nom"),
              ),
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Âge"),
              ),
              TextField(
                controller: classeController,
                decoration: const InputDecoration(labelText: "Classe"),
              ),
              TextField(
                controller: avatarController,
                decoration: const InputDecoration(labelText: "Avatar (ex: 👧, 👦, 👶)"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Annuler"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
            onPressed: () {
              final newEnfant = {
                "nom": nomController.text,
                "age": int.tryParse(ageController.text) ?? 0,
                "classe": classeController.text,
                "avatar": avatarController.text.isNotEmpty ? avatarController.text : "👶",
              };
              setState(() {
                if (index == null) {
                  enfants.add(newEnfant);
                } else {
                  enfants[index] = newEnfant;
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

  void _supprimerEnfant(int index) {
    setState(() {
      enfants.removeAt(index);
    });
  }

  Widget _buildEnfantCard(int index) {
    final enfant = enfants[index];
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        leading: CircleAvatar(
          radius: 24,
          child: Text(enfant["avatar"], style: const TextStyle(fontSize: 24)),
        ),
        title: Text(enfant["nom"],
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        subtitle: Text("Âge : ${enfant["age"]} ans\nClasse : ${enfant["classe"]}"),
        isThreeLine: true,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.orange),
              onPressed: () => _showForm(enfant: enfant, index: index),
              tooltip: "Modifier",
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () => _supprimerEnfant(index),
              tooltip: "Supprimer",
            ),
          ],
        ),
      ),
    );
  }

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
        title: const Text("Enfants", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _showMenu(context),
        ),
      ),
      body: enfants.isEmpty
          ? const Center(
              child: Text(
                "Aucun enfant pour le moment.\nAjoutez-en un avec le bouton +",
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemCount: enfants.length,
              itemBuilder: (context, index) => _buildEnfantCard(index),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        onPressed: () => _showForm(),
        tooltip: 'Ajouter un enfant',
        child: const Icon(Icons.add),
      ),
    );
  }
}
