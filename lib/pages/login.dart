import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taskmanagementapp/pages/widgets/widgets.dart';
import 'package:taskmanagementapp/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  AuthService service = AuthService();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

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
              margin:const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Welcome",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    const Text("Login to your account"),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    textFieldContainer(
                        email,
                        "Email",
                        false,
                      const  Icon(
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
                      const  Icon(
                          Icons.password_outlined,
                          size: 16,
                        )),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    SizedBox(
                      height: size.height * 0.063,
                      child: buttonContainer("Login", () {
                        if (_formKey.currentState!.validate()) {
                          service.userLogin(email.text, password.text, context);
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
                          "Don't have an account ?  ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/register");
                            },
                            child: Text(
                              "Signup",
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
