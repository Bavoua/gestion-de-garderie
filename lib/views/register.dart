import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController loginController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  final TextEditingController confirmPwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Formulaire D'inscription"),
        backgroundColor: Colors.blueAccent, // Utilise ta couleur préférée ici
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              "Créer un compte",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[800],
              ),
            ),
            SizedBox(height: 30),
            // Nom complet
            TextField(
              controller: nameController,
              decoration: _inputDecoration("Nom complet", Icons.person),
            ),
            SizedBox(height: 15),
            // Email
            TextField(
              controller: emailController,
              decoration: _inputDecoration("Email", Icons.email),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 15),
            // Login
            TextField(
              controller: loginController,
              decoration: _inputDecoration("Nom d'utilisateur", Icons.account_circle),
            ),
            SizedBox(height: 15),
            // Mot de passe
            TextField(
              controller: pwdController,
              obscureText: true,
              decoration: _inputDecoration("Mot de passe", Icons.lock),
            ),
            SizedBox(height: 15),
            // Confirmer mot de passe
            TextField(
              controller: confirmPwdController,
              obscureText: true,
              decoration: _inputDecoration("Confirmer le mot de passe", Icons.lock_outline),
            ),
            SizedBox(height: 30),
            // Bouton d'inscription
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_validateForm(context)) {
                    // Si la validation est réussie, on peut rediriger
                    Navigator.pushNamed(context, "/home"); // Redirige vers la page d'accueil
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Utilise ta couleur préférée
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "S'inscrire",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Bouton retour à la connexion
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Retourne à la page de connexion
              },
              child: Text(
                "← Retour à la connexion",
                style: TextStyle(color: Colors.blueGrey[700]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fonction pour créer une décoration d'input
  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  // Validation du formulaire
  bool _validateForm(BuildContext context) {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        loginController.text.isEmpty ||
        pwdController.text.isEmpty ||
        confirmPwdController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Veuillez remplir tous les champs"),
        backgroundColor: Colors.red,
      ));
      return false;
    }
    if (pwdController.text != confirmPwdController.text) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Les mots de passe ne correspondent pas"),
        backgroundColor: Colors.red,
      ));
      return false;
    }
    return true;
  }
}
