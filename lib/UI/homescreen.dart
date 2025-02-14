import 'package:flutter/material.dart';

import '../Utils/base.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _Doctor_DashboardState();
}

class _Doctor_DashboardState extends State<Dashboard> {


  @override
  void initState() {
    super.initState();

  }

  GlobalKey<NavigatorState> _yourKey = GlobalKey<NavigatorState>();
  _backPressed(GlobalKey<NavigatorState> _yourKey) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Dashboard()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Get screen size once
    return WillPopScope(
      onWillPop:() => _backPressed(_yourKey),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Welcome To Home",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/welcome.png",
                    fit: BoxFit.cover, // Ensures full-screen coverage
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
