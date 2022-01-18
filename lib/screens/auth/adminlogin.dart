import 'package:cool_alert/cool_alert.dart';
import 'package:covid_app/screens/home/admin/adminhome.dart';
import 'package:covid_app/services/load_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({Key? key}) : super(key: key);
  static const id='/adminlogin';
  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text('Login as an Admin'),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(30, 10),bottomRight: Radius.elliptical(30, 10))
          ),
        ),
      ),
      body: Forms(),
    );
  }
}


class Forms extends StatefulWidget {
  const Forms({Key? key}) : super(key: key);

  @override
  _FormsState createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  double? _height;
  double? _width;
  double? _pixelRatio;
  bool _large = false;
  bool _medium = false;
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  bool _isloading = false;
  final keys = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    return _isloading
        ? Container(
      child: Center(child: CircularProgressIndicator()),
    )
        : Form(
        key: keys,
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: (Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height:10.0),
              TextFormField(

                decoration: InputDecoration(
border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.circular(2.0),
        ),
                    hintText: "Enter your email",
                    labelText: "Email",
                    icon: Icon(Icons.email)),
                validator: (value) {
                  return RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value!)
                      ? null
                      : "Please Enter Correct Email";
                },
                controller: emailEditingController,
              ),
              SizedBox(height:10.0),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    hintText: "Enter your password",
                    labelText: "Password",
                    icon: Icon(Icons.lock)),
                validator: (value) {
                  return value!.length > 6
                      ? null
                      : "Enter Password 6+ characters";
                },

                controller: passwordEditingController,
              ),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    signIn();
                  },
                    child: Text('Continue as admin',
                        ),
                  ),
                ),

            ],
          )),
        ));
  }

  signIn() async {
    if (keys.currentState!.validate()) {
      setState(() {
        _isloading = true;
      });
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: emailEditingController.text,
            password: passwordEditingController.text);

        await loadAdmin(emailEditingController.text);
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, AdminHome.id);
      } on FirebaseAuthException catch (e) {
        print('aa0');
        if (e.code == 'user-not-found') {
          print('aa');
          coolalertfailure('No user found for that email.');
          setState(() {
            _isloading = false;
          });
          print('aa2');
        } else if (e.code == 'wrong-password') {
          coolalertfailure('Wrong password provided for that user.');
          setState(() {
            _isloading = false;
          });
        } else {
          coolalertfailure('Error $e');
          setState(() {
            _isloading = false;
          });
        }
      } catch (e) {
        setState(() {
          _isloading = false;
        });
        print(e);
      }
    }
  }


  coolalertsuccess(String text) {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        title: 'Success',
        text: text,
        loopAnimation: false,
        confirmBtnColor: Colors.pink[600]!,
        backgroundColor: Colors.pink[100]!
    );
  }

  coolalertfailure(String text) {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: 'Oops...',
        text: text,
        loopAnimation: false,
        confirmBtnColor: Colors.pink[600]!,
        backgroundColor: Colors.pink[100]!
    );
  }
}