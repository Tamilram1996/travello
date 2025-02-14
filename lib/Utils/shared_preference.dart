import 'package:shared_preferences/shared_preferences.dart';


setUserName(String data,String Password) async {
  print("userName" + data);
  print("Password" + Password);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('userName', data);
  prefs.setString('Password', Password);
}

Future<String> getUserName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString('userName') != null && prefs.getString('Password') != null &&
      prefs.getString('userName')!.isNotEmpty) {
    print("userName" + prefs.getString('userName').toString());
    print("Password" + prefs.getString('Password').toString());
  } else {
    print("Token is  Empty");
  }
  return prefs.getString('userName') != null && prefs.getString('Password') != null
      ? prefs.getString('userName').toString()
      : "";
}


void saveUserCredentials(String email, String password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('registeredEmail', email);
  await prefs.setString('registeredPassword', password);
}

Future<bool> validateUser(String email, String password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? storedEmail = prefs.getString('registeredEmail');
  String? storedPassword = prefs.getString('registeredPassword');

  return (email == storedEmail && password == storedPassword);
}
