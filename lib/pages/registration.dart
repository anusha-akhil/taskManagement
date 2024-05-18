

import 'package:flutter/material.dart';
import 'package:taskmanagementapp/pages/widgets/widgets.dart';
import 'package:taskmanagementapp/services/auth_service.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  AuthService service = AuthService();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confrmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "SignUp",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    const Text("Create your account"),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    textFieldContainer(
                        email,
                        "Email",
                        false,
                        Icon(
                          Icons.email,
                          size: 16,
                        )),
                        SizedBox(
                      height: size.height * 0.01,
                    ),
                    textFieldContainer(
                        password,
                        "Password",
                        true,
                        Icon(
                          Icons.password_outlined,
                          size: 16,
                        )),
                         SizedBox(
                      height: size.height * 0.01,
                    ),
                    textFieldContainer(
                        confrmPassword,
                        "Confirm Password",
                        true,
                        Icon(
                          Icons.password_outlined,
                          size: 16,
                        )),
                         SizedBox(
                      height: size.height * 0.03,
                    ),
                    SizedBox(
                      height: size.height * 0.063,
                      child: buttonContainer("Register", () {
                        if (_formKey.currentState!.validate()) {
                          print("snjnfn---${email.text}");
                          if (password.text == confrmPassword.text) {
                            service.userRegistration(
                                email.text, password.text, context);
                          }else{
                            showToastWidget("Password dodnt match");
                        }
                        }
                      }, context),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account ?  ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/login");
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    )
                  ]),
            ),
          ),
        ),
      )),
    );
  }
}
