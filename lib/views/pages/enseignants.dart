import 'package:flutter/material.dart';
import 'enfants.dart';
import 'activites.dart';
import 'parents.dart';
import 'repas.dart';
import 'enseignants.dart';

class EnseignantsPage extends StatefulWidget {
  const EnseignantsPage({super.key});

  @override
  State<EnseignantsPage> createState() => _EnseignantsPageState();
}

class _EnseignantsPageState extends State<EnseignantsPage> {
  List<Map<String, dynamic>> enseignants = [
    {"nom": "Mme Dupuis", "matiere": "Mathématiques", "email": "dupuis.maths@ecole.com", "emoji": "🧮"},
    {"nom": "M. Lemoine", "matiere": "Sciences", "email": "lemoine.sci@ecole.com", "emoji": "🔬"},
    {"nom": "Mme Ricard", "matiere": "Français", "email": "ricard.fr@ecole.com", "emoji": "📖"},
  ];

  void _showForm({Map<String, dynamic>? enseignant, int? index}) {
    final nomController = TextEditingController(text: enseignant?["nom"] ?? "");
    final matiereController = TextEditingController(text: enseignant?["matiere"] ?? "");
    final emailController = TextEditingController(text: enseignant?["email"] ?? "");
    final emojiController = TextEditingController(text: enseignant?["emoji"] ?? "");

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(index == null ? "Ajouter un enseignant" : "Modifier l'enseignant"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: nomController, decoration: const InputDecoration(labelText: "Nom")),
              TextField(controller: matiereController, decoration: const InputDecoration(labelText: "Matière")),
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
              final nouveau = {
                "nom": nomController.text,
                "matiere": matiereController.text,
                "email": emailController.text,
                "emoji": emojiController.text.isNotEmpty ? emojiController.text : "🧑‍🏫",
              };

              setState(() {
                if (index == null) {
                  enseignants.add(nouveau);
                } else {
                  enseignants[index] = nouveau;
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

  void _supprimerEnseignant(int index) {
    setState(() {
      enseignants.removeAt(index);
    });
  }

  Widget _buildEnseignantCard(int index) {
    final e = enseignants[index];
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        leading: CircleAvatar(radius: 24, child: Text(e["emoji"], style: const TextStyle(fontSize: 24))),
        title: Text(e["nom"], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        subtitle: Text("Matière : ${e["matiere"]}\nEmail : ${e["email"]}"),
        isThreeLine: true,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: const Icon(Icons.edit, color: Colors.orange), onPressed: () => _showForm(enseignant: e, index: index)),
            IconButton(icon: const Icon(Icons.delete, color: Colors.redAccent), onPressed: () => _supprimerEnseignant(index)),
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
        title: const Text("Enseignants", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () => _showMenu(context)),
      ),
      body: enseignants.isEmpty
          ? const Center(
              child: Text(
                "Aucun enseignant enregistré.\nCliquez sur + pour en ajouter.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: enseignants.length,
              itemBuilder: (context, index) => _buildEnseignantCard(index),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        onPressed: () => _showForm(),
        tooltip: 'Ajouter un enseignant',
        child: const Icon(Icons.add),
      ),
    );
  }
}
