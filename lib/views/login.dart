import 'package:flutter/material.dart';
import 'package:garderie_app/constants/colors.dart';

class Login extends StatelessWidget {
  final TextEditingController loginTextController = TextEditingController();
  final TextEditingController pwdTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: AppColor.btnColor,
        elevation: 0,
        title: const Text(
          "Garderie APP",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: 1.1,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: AppColor.btnColor.withOpacity(0.15),
                child: const Icon(
                  Icons.child_care,
                  size: 50,
                  color: Colors.lightBlue,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Bienvenue sur votre application",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[800],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Veuillez vous connecter pour continuer",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey[500],
                ),
              ),
              const SizedBox(height: 32),

              // Champ utilisateur
              TextField(
                controller: loginTextController,
                decoration: InputDecoration(
                  labelText: "Nom d'utilisateur",
                  prefixIcon: const Icon(Icons.person),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Champ mot de passe
              TextField(
                controller: pwdTextController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Mot de passe",
                  prefixIcon: const Icon(Icons.lock),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Bouton connexion
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.login),
                  onPressed: () {
                    bool isLoginSuccessful = true;

                    if (isLoginSuccessful) {
                      Navigator.pushNamed(context, "/home");
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Échec de connexion. Vérifiez vos identifiants"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.btnColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                  ),
                  label: const Text(
                    "Se connecter",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 25),
              const Text("──────────────  OU  ──────────────",
                  style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 20),

              // Lien inscription
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/register");
                },
                child: Text(
                  "Je suis nouveau. Je m'inscris",
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: AppColor.btnColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
