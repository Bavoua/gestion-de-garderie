import 'package:flutter/material.dart';
import 'enfants.dart';
import 'activites.dart';
import 'parents.dart';
import 'repas.dart';
import 'enseignants.dart';

class RepasPage extends StatefulWidget {
  const RepasPage({super.key});

  @override
  State<RepasPage> createState() => _RepasPageState();
}

class _RepasPageState extends State<RepasPage> {
  List<Map<String, dynamic>> repas = [
    {"nom": "Spaghetti Bolognaise", "type": "Déjeuner", "jour": "Lundi", "emoji": "🍝"},
    {"nom": "Poulet Riz", "type": "Déjeuner", "jour": "Mardi", "emoji": "🍗"},
    {"nom": "Croissant & Lait", "type": "Petit Déjeuner", "jour": "Mercredi", "emoji": "🥐"},
  ];

  void _showForm({Map<String, dynamic>? repasData, int? index}) {
    final nomController = TextEditingController(text: repasData?["nom"] ?? "");
    final typeController = TextEditingController(text: repasData?["type"] ?? "");
    final jourController = TextEditingController(text: repasData?["jour"] ?? "");
    final emojiController = TextEditingController(text: repasData?["emoji"] ?? "");

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(index == null ? "Ajouter un repas" : "Modifier le repas"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nomController,
                decoration: const InputDecoration(labelText: "Nom du repas"),
              ),
              TextField(
                controller: typeController,
                decoration: const InputDecoration(labelText: "Type (ex : Déjeuner)"),
              ),
              TextField(
                controller: jourController,
                decoration: const InputDecoration(labelText: "Jour"),
              ),
              TextField(
                controller: emojiController,
                decoration: const InputDecoration(labelText: "Emoji (ex : 🍝)"),
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
              final nouveauRepas = {
                "nom": nomController.text,
                "type": typeController.text,
                "jour": jourController.text,
                "emoji": emojiController.text.isNotEmpty ? emojiController.text : "🍽️",
              };

              setState(() {
                if (index == null) {
                  repas.add(nouveauRepas);
                } else {
                  repas[index] = nouveauRepas;
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

  void _supprimerRepas(int index) {
    setState(() {
      repas.removeAt(index);
    });
  }

  Widget _buildRepasCard(int index) {
    final r = repas[index];
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        leading: CircleAvatar(
          radius: 24,
          child: Text(r["emoji"], style: const TextStyle(fontSize: 24)),
        ),
        title: Text(r["nom"], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        subtitle: Text("Type : ${r["type"]}\nJour : ${r["jour"]}"),
        isThreeLine: true,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.orange),
              onPressed: () => _showForm(repasData: r, index: index),
              tooltip: "Modifier",
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () => _supprimerRepas(index),
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
        title: const Text("Repas", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _showMenu(context),
        ),
      ),
      body: repas.isEmpty
          ? const Center(
              child: Text(
                "Aucun repas enregistré.\nCliquez sur + pour en ajouter.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: repas.length,
              itemBuilder: (context, index) => _buildRepasCard(index),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        onPressed: () => _showForm(),
        tooltip: 'Ajouter un repas',
        child: const Icon(Icons.add),
      ),
    );
  }
}
