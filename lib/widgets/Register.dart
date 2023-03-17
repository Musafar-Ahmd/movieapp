import 'package:flutter/material.dart';
import 'package:movieapp/widgets/Loginpage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  /// for fetching the current state of form
  GlobalKey<FormState> formkey = GlobalKey();
  /// for checking the password is visible or not
  bool showpass = true;
  var confirmpass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text("Registration Page"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Image.network('https://raw.githubusercontent.com/realflutternuggets/flutter-ui-plant-app/main/assets/images/signup.png',
                  width: 200,
                  height: 200,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "E-mail",
                      labelText: 'E-mail',
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
                      hintText: "PassWord",
                      labelText: 'Password',
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
                    confirmpass = password;
                    if (password.isEmpty || password.length < 6) {
                      return "enter a valid password";
                    } else {
                      return null;
                    }
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (cpass){
                    if(cpass != confirmpass || cpass.isEmpty){
                      return 'Password mismatch';
                    }else{
                      return null;
                    }
                  },
                  obscureText: true,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                      hintText: "Confirm Password",
                      labelText: 'Confirm Password',
                      prefixIcon: Icon(Icons.password),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100))),
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
                                builder: (context) => LoginValidation()));
                      }
                    },
                    child:
                    const Text('Register', style: TextStyle(fontSize: 15))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}