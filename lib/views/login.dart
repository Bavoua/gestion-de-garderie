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
        title: Text("Garderie APP"),
        backgroundColor: AppColor.btnColor,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo ou icône
              CircleAvatar(
                radius: 45,
                backgroundColor: AppColor.btnColor.withOpacity(0.2),
                child: Icon(Icons.child_care, size: 50, color: AppColor.btnColor),
              ),
              SizedBox(height: 20),
              Text(
                "Bienvenue sur votre Application",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[800]),
              ),
              SizedBox(height: 12),
              Text(
                "Veuillez vous connecter pour continuer",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColor.btnColor),
              ),
              SizedBox(height: 30),
              // Champ login
              TextField(
                controller: loginTextController,
                decoration: InputDecoration(
                  labelText: "Nom d'utilisateur",
                  prefixIcon: Icon(Icons.person),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Champ mot de passe
              TextField(
                controller: pwdTextController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Mot de passe",
                  prefixIcon: Icon(Icons.lock),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Bouton connexion
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    bool isLoginSuccessful = true;

                    if (isLoginSuccessful) {
                      Navigator.pushNamed(context, "/home");
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "Échec de connexion. Vérifiez vos identifiants"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.btnColor,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Se connecter",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text("─────────────── OU ───────────────",
                  style: TextStyle(color: Colors.grey)),
              SizedBox(height: 20),
              // Bouton inscription
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
                      decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
