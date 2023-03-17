import 'package:flutter/material.dart';
import 'package:movieapp/widgets/Home.dart';
import 'package:movieapp/widgets/Register.dart';


class LoginValidation extends StatefulWidget {
  const LoginValidation({Key key}) : super(key: key);

  @override
  State<LoginValidation> createState() => _LoginValidationState();
}

class _LoginValidationState extends State<LoginValidation> {
  GlobalKey<FormState> formkey = GlobalKey();

  /// for fetching the current state of form
  bool showpass = true;

  /// for checking the password is visible or not
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login ",),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Image.network(
                  'https://raw.githubusercontent.com/Musafar-Ahmd/project_plantapp/master/assets/images/signin.png',
                  width: 200,
                  height: 200,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "E-mail",
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100))),
                  validator: (uname) {
                    if (uname.isEmpty ||
                        !uname.contains('@') ||
                        !uname.contains('.')) {
                      return 'Enter a valid UserName';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscuringCharacter: '*',
                  obscureText: showpass,
                  decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(Icons.password),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            if (showpass) {
                              showpass = false;
                            } else {
                              showpass = true;
                            }
                          });
                        },
                        icon: Icon(showpass == true
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),

                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100))),
                  validator: (password) {
                    if (password.isEmpty || password.length < 6) {
                      return "enter a valid password";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: ElevatedButton(
                    onPressed: () {
                      final valid = formkey.currentState.validate();
                      if (valid) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      }
                    },
                    child: const Text('Login', style: TextStyle(fontSize: 15))),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                  },
                  child: const Text(
                    "Not a User?? SignUp Here!!",
                    style: TextStyle(fontSize: 15),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}