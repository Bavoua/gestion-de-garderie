import 'package:flutter/material.dart';
import 'enfants.dart';
import 'activites.dart';
import 'parents.dart';
import 'repas.dart';
import 'enseignants.dart';

class ActivitesPage extends StatefulWidget {
  const ActivitesPage({super.key});

  @override
  State<ActivitesPage> createState() => _ActivitesPageState();
}

class _ActivitesPageState extends State<ActivitesPage> {
  List<Map<String, dynamic>> activites = [
    {"nom": "Peinture", "animateur": "Mme Sophie", "heure": "10h00", "emoji": "🎨"},
    {"nom": "Danse", "animateur": "M. Karim", "heure": "14h00", "emoji": "💃"},
    {"nom": "Lecture", "animateur": "Mme Clara", "heure": "9h00", "emoji": "📚"},
  ];

  void _showForm({Map<String, dynamic>? activite, int? index}) {
    final nomController = TextEditingController(text: activite?["nom"] ?? "");
    final animateurController = TextEditingController(text: activite?["animateur"] ?? "");
    final heureController = TextEditingController(text: activite?["heure"] ?? "");
    final emojiController = TextEditingController(text: activite?["emoji"] ?? "");

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(index == null ? "Ajouter une activité" : "Modifier l'activité"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: nomController, decoration: const InputDecoration(labelText: "Nom")),
              TextField(controller: animateurController, decoration: const InputDecoration(labelText: "Animateur")),
              TextField(controller: heureController, decoration: const InputDecoration(labelText: "Heure")),
              TextField(controller: emojiController, decoration: const InputDecoration(labelText: "Emoji")),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Annuler")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
            onPressed: () {
              final nouvelleActivite = {
                "nom": nomController.text,
                "animateur": animateurController.text,
                "heure": heureController.text,
                "emoji": emojiController.text.isNotEmpty ? emojiController.text : "🎯",
              };

              setState(() {
                if (index == null) {
                  activites.add(nouvelleActivite);
                } else {
                  activites[index] = nouvelleActivite;
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

  void _supprimerActivite(int index) {
    setState(() {
      activites.removeAt(index);
    });
  }

  Widget _buildActiviteCard(int index) {
    final a = activites[index];
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        leading: CircleAvatar(radius: 24, child: Text(a["emoji"], style: const TextStyle(fontSize: 24))),
        title: Text(a["nom"], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        subtitle: Text("Animateur : ${a["animateur"]}\nHeure : ${a["heure"]}"),
        isThreeLine: true,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: const Icon(Icons.edit, color: Colors.orange), onPressed: () => _showForm(activite: a, index: index)),
            IconButton(icon: const Icon(Icons.delete, color: Colors.redAccent), onPressed: () => _supprimerActivite(index)),
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
        title: const Text("Activités", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () => _showMenu(context)),
      ),
      body: activites.isEmpty
          ? const Center(
              child: Text(
                "Aucune activité enregistrée.\nCliquez sur + pour en ajouter.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: activites.length,
              itemBuilder: (context, index) => _buildActiviteCard(index),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        onPressed: () => _showForm(),
        tooltip: 'Ajouter une activité',
        child: const Icon(Icons.add),
      ),
    );
  }
}
