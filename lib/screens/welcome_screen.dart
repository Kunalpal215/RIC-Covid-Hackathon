// Importing General Packages
import 'package:covid_app/components/animatedbuttonui.dart';
import 'package:covid_app/screens/auth/adminlogin.dart';
import 'package:flutter/material.dart';

// Importing Firebase Packages

// Importing Screens
import 'package:covid_app/screens/auth/login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const id = '/welcome';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomRight: Radius.elliptical(80, 60)),
                      color: Colors.pink,
                  ),
                height: 400,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30,130,0,0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Covid",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 38
                        )
                      ),
                      Text(
                          "Management",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 38
                          )
                      ),
                      Text(
                          "App",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 38
                          )
                      ),
                    ],
                  ),
                )
              ),
              const Spacer(),
              const Spacer(),
              Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
                child: FlatButton(

                  onPressed: (){Navigator.pushNamed(context, LoginScreen.id);},
                  child: Text("I am a User",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize:19,
                      )
                  ),
                  color:Colors.grey[850],
                  minWidth: 360,
                  height: 50,
                  shape: RoundedRectangleBorder(side: BorderSide(
                      width: 1,
                      style: BorderStyle.solid
                  ),
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
              SizedBox(height:15),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                    child: FlatButton(

                      onPressed: (){Navigator.pushNamed(context, AdminLoginScreen.id);},
                      child: Text("I am an Admin",
                          style: TextStyle(
                            fontSize:19,
                          )
                      ),
                      color:Colors.grey[100],
                      minWidth: 360,
                      height: 50,
                      shape: RoundedRectangleBorder(side: BorderSide(
                          width: 1,
                          style: BorderStyle.solid
                      ),
                          borderRadius: BorderRadius.circular(30)),
                    )
                ),
              ),
              Spacer(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
