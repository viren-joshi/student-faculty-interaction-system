import 'package:shared_preferences/shared_preferences.dart';
class SharedPrefManager{

  static void login(int id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('Auth', true);
    sharedPreferences.setInt('ID', id);
  }

  static void logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('Auth', false);
    sharedPreferences.remove('ID');
  }

  static Future<bool> isLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool('Auth') ?? false;
  }

  static Future<int> getId() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt('ID') ?? -1;
  }

  static void loggedInAsStudent(bool b) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('LoggedInAsStudent', b);
  }

  static Future<bool> isLoggedInAsStudent() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool('LoggedInAsStudent') ?? true ;
  }

}