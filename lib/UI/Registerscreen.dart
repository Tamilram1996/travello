import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Database/database_helper.dart';
import '../Utils/base.dart';
import '../Utils/shared_preference.dart';
import '../Utils/utils.dart';
import 'loginscreen.dart';
import 'otpscreen.dart';

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  bool _isPasswordVisible = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isChecked = false;
  final DatabaseHelper dbHelper = DatabaseHelper();

  void registerUser() async {
    String name = _nameController.text;
    String email = _emailController.text;
    String phone = _phoneController.text;
    String password = _passwordController.text;

    if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("All fields are required")),
      );
      return;
    }

    try {
      await dbHelper.insertUser({
        'name': name,
        'email': email,
        'phone': phone,
        'password': password
      });
      toastMessage(context, "Registration successful!  Please login.", Colors.green);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Loginscreen()),
      );
    } catch (e) {
      toastMessage(context, "Email already exists! Use a different email", Colors.green);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Stack(
                alignment: Alignment.center, // Aligns children properly
                children: [
                  SizedBox(
                    width: double.infinity,
                    // Ensures image does not overflow
                    child: Image.asset(
                      'assets/login.png',
                      fit: BoxFit
                          .cover, // Adjust as needed (contain, fill, etc.)
                    ),
                  ),
                  Positioned(
                    top: 155,
                    left: 0,
                    right: 0, // Makes text responsive within the stack
                    child: Center(
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 180,
                    child: Text(
                      "by creating a free account",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Full name",
                  hintStyle:
                      TextStyle(color: Colors.grey.shade400, fontSize: 14),
                  filled: true,
                  fillColor: Color(0xFFEEEEEE),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon:
                      Icon(Icons.person_outline_sharp, color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Valid email",
                  hintStyle:
                      TextStyle(color: Colors.grey.shade400, fontSize: 14),
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
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: _phoneController,
                maxLength: 10,
                decoration: InputDecoration(
                  hintText: "Phone Number",
                  hintStyle:
                      TextStyle(color: Colors.grey.shade400, fontSize: 14),
                  filled: true,
                  fillColor: Color(0xFFEEEEEE),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: Icon(Icons.phone_android, color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: "Strong Password",
                  hintStyle:
                      TextStyle(color: Colors.grey.shade400, fontSize: 14),
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
            SizedBox(height: 4),
            Row(
              children: [
                Transform.scale(
                  scale: 0.8,
                  child: Checkbox(
                      value: _isChecked,
                      activeColor: Colors.black, // Makes the tick black
                      onChanged: (value) {
                        setState(() {
                          _isChecked = value!;
                        });
                      }),
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 12, color: Colors.black),
                      children: [
                        TextSpan(text: "By checking the box you agree to our "),
                        TextSpan(
                          text: "Terms",
                          style:
                              TextStyle(fontSize: 12, color: Base.primaryColor),
                        ),
                        TextSpan(text: " and "),
                        TextSpan(
                          text: "Conditions.",
                          style:
                              TextStyle(fontSize: 12, color: Base.primaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
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
                      if(_nameController.text.isEmpty){
                        toastMessage(context, "Please Enter the Name", Colors.red);
                      }
                      if(_emailController.text.isEmpty){
                        toastMessage(context, "Please Enter the Mail", Colors.red);
                      }
                      else  if(_phoneController.text.isEmpty){
                        toastMessage(context, "Please Enter the Phonenumber", Colors.red);
                      }
                      else if(_passwordController.text.isEmpty){
                        toastMessage(context, "Please Enter the Password", Colors.red);
                      }
                      else if(_isChecked==false){
                        toastMessage(context, "Please Accept the terms checkbox", Colors.red);
                        print(_isChecked.toString());
                      }
                     else{
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setString('registeredEmail', _emailController.text.toString());
                        await prefs.setString('registeredPassword', _passwordController.text.toString());

                        setUserName(_emailController.text.toString(), _passwordController.text.toString());
                        registerUser();
                        // final dbHelper = DatabaseHelper();
                        // await dbHelper.insertUser({
                        //   'name': _nameController.text,
                        //   'email': _emailController.text,
                        //   'phone': _phoneController.text,
                        //   'password': _passwordController.text,
                        //   // Store hashed password for security
                        // });
                        // print(_emailController.text.toString());
                        // print(_passwordController.text.toString());
                        // Navigator.pop(context);
                        // toastMessage(context, "Registration successful!", Colors.green);
                      }
                  },
                  child: Text(
                    "Next  >",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already a member"),
                  SizedBox(width: 10),
                  Text("Login in",
                      style: TextStyle(
                        color: Colors.red,
                      )),
                ],
              ),
            ),
            SizedBox(height: 40),
          ]),
        ));
  }
}
