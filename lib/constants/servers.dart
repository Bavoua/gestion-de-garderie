class AppServer {
  static const API = "http://localhost:8006";
  static const ACTIVTES = API + "/activites";
  static const ENFANTS = API + "/enfants";
  static const ENSEIGANTS = API + "/enseignants";
  static const PARENTS = API + "/parents";
  static const REPAS = API + "/repas";
  static const LOGIN = API + "auth/login";


  static const headers ={
    'Content-Type' : 'application/json',
    "Access-Control-Allow-Origin": "*",
    'Accept':'application/json'
  };

}
