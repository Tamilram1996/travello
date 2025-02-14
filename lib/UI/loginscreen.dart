import 'package:flutter/material.dart';
import 'package:travelo/UI/Registerscreen.dart';
import 'package:travelo/Utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Database/database_helper.dart';
import '../Utils/base.dart';
import '../Utils/shared_preference.dart';
import 'otpscreen.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  bool _isPasswordVisible = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  String? _errorMessage;
  bool _checkbox =false;
  final DatabaseHelper dbHelper = DatabaseHelper();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: Alignment.center, // Aligns children properly
                  children: [
                    SizedBox(
                      width: double.infinity, // Ensures image does not overflow
                      child: Image.asset(
                        'assets/login.png',
                        fit: BoxFit.cover, // Adjust as needed (contain, fill, etc.)
                      ),
                    ),
                    Positioned(
                      top: 155,
                      left: 0,
                      right: 0, // Makes text responsive within the stack
                      child: Center(
                        child: Text(
                          "Welcome back",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 180,
                      child: Text(
                        "Sign in to access your account",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  height: 45, // Adjust height as needed
          
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "Enter your email",
                      hintStyle: TextStyle(color: Colors.grey.shade400,fontSize: 14),
                      filled: true,
                      fillColor: Color(0xFFEEEEEE),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: Icon(Icons.email_outlined, color: Colors.grey),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  height: 45, // Adjust height as needed
                  child: TextField(
                    controller: _passwordcontroller,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                      filled: true,
                      fillColor: Color(0xFFEEEEEE),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Transform.scale(
                          scale: 0.8, // Adjust the size
                          child: Checkbox(
                            value: _checkbox,
                            activeColor: Colors.black, // Makes the tick black
                            onChanged: (value) {
                              setState(() {
                                _checkbox = value!; // Correctly updates the checkbox state
                              });
                            },
                          ),
                        ),
                        Text(
                          "Remember me",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    Text(
                      "Forgot password?",
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontSize: 12),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Base.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      String email = _emailController.text.toString();
                      String password = _passwordcontroller.text.toString();
                      if(_emailController.text.isEmpty){
                        toastMessage(context, "Please Enter the Mail", Colors.red);
                      }
                      else if (!isValidEmail(_emailController.text)) {
                        setState(() {
                          toastMessage(context, "Please Enter the Proper-Mail @ ", Colors.red);
                        });
                        return;
                      }
                      else  if(_passwordcontroller.text.isEmpty){
                        toastMessage(context, "Please Enter the Password", Colors.red);
                      }
                      else {
                        final user = await dbHelper.getUserByEmail(email);

                        bool isValid = await validateUser(_emailController.text, _passwordcontroller.text);
                        setUserName(_emailController.text.toString(),
                            _passwordcontroller.text.toString());
                        if (user != null && user['password'] == password) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => OtpScreen()),
                          );
                        } else {
                          toastMessage(context,
                              "Invalid email or password.Please try again ",
                              Colors.red);
                        }
                      }
                    },
                    child: Text(
                      "Next  >",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("New member?",
                    style: TextStyle(color: Colors.black,fontSize: 13),
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Registerscreen()),
                      );
                    },
                    child: Text(
                      "Register now",
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontSize: 13),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
Future<bool> validateUser(String email, String password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? storedEmail = prefs.getString('registeredEmail');
  String? storedPassword = prefs.getString('registeredPassword');

  return (email == storedEmail && password == storedPassword);
}
bool isValidEmail(String email) {
  String pattern =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  RegExp regex = RegExp(pattern);
  return regex.hasMatch(email);
}