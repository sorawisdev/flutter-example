import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:weather_app/model/profile.dart';
import 'package:weather_app/screen/weatherscreen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  Profile myProfile = Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          //กรณีที่มี error เกิดจากการเชื่อมต่อ

          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }

          //ถ้าสามรถเชื่อมต่อ firebase สำเร็จ
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(title: const Text("Login Account")),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            const Text("Email : "),
                            TextFormField(
                              initialValue: myProfile.email,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: "Please enter email"),
                                EmailValidator(
                                    errorText: "Invalid email format"),
                              ]),
                              onSaved: (String? email) {
                                myProfile.email = email;
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text("Password : "),
                            TextFormField(
                              initialValue: myProfile.password,
                              validator: RequiredValidator(
                                  errorText: "Please enter Password"),
                              obscureText: true,
                              onSaved: (String? password) {
                                myProfile.password = password;
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                icon: const Icon(Icons.login),
                                label: const Text(
                                  "Sign in",
                                  style: TextStyle(fontSize: 15),
                                ),
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState?.save();
                                    try {
                                      await FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                              email: myProfile.email.toString(),
                                              password:
                                                  myProfile.password.toString())
                                          .then((value) {
                                        formKey.currentState!.reset();
                                        Fluttertoast.showToast(
                                            msg:
                                                'You have successfully created an account for',
                                            gravity: ToastGravity.CENTER);
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const MyHomePage();
                                        }));
                                      });
                                    } on FirebaseException catch (e) {
                                      String message = '';
                                      if (e.code == 'email.already-in-use') {
                                        message =
                                            "This email already exists Please use another email.";
                                      } else if (e.code == 'weak-password') {
                                        message =
                                            "Password must be at least 6 characters long.";
                                      } else {
                                        message = e.message!;
                                      }
                                      Fluttertoast.showToast(
                                          msg: e.toString(),
                                          gravity: ToastGravity.CENTER);
                                    }
                                  }
                                },
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            );
          }

          //กรณีไม่มี error ให้โหลดข้อมูลหน้าแอปพลิเคชัน
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
