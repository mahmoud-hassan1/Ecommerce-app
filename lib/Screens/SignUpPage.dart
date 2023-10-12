// ignore_for_file: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:lottie/lottie.dart';

import '../NavBar.dart';
import '../constant/constant.dart';
import '../logic/helper.dart';
import 'HomePage.dart';
import 'LoginPage.dart';

// ignore: must_be_immutable
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> keyForm = GlobalKey();
  bool isLoading = false;
  String? username;
  String? email;
  String? password;
  String? confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: ListView(
            children: [
              Lottie.asset('assets/images/animation_lly51vak.json', height: MediaQuery.of(context).size.height *.4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Form(
                  key: keyForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Sign Up
                      const Text('Sign Up', style: TextStyle(color: Color(0xFF7a62c3), fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 30),
                      // UserName TextField
                      CustomTextFormField(
                          onChanged: (data) {
                            username = data;
                          },
                          label: 'Username',
                          hintText: 'Enter Your Username'),
                      const SizedBox(height: 20),
                      // Email TextField
                      CustomTextFormField(
                          onChanged: (data) {
                            email = data;
                          },
                          label: 'Email',
                          hintText: 'Enter Your Email'),
                      const SizedBox(height: 20),

                      // Password TextField
                      CustomTextFormField(
                          onChanged: (data) {
                            password = data;
                          },
                          label: 'Password',
                          hintText: 'Enter Your Password',
                          obscureText: true),
                      const SizedBox(height: 20),

                      // Confirm Password TextField
                      CustomTextFormField(
                          onChanged: (data) {
                            confirmPassword = data;
                          },
                          label: 'Confirm Password',
                          hintText: 'Confirm Your Password',
                          obscureText: true),
                      const SizedBox(height: 30),

                      // Sign Up Button
                      CustomButton(
                        onTap: () async {
                          if (confirmPassword == password) {
                            if (keyForm.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              await signUp(context, email!, password!,username!);
                              setState(() {
                                isLoading = false;
                              });
                            }
                          } else {
                            showSnackBar(context, "Password and it's confirmation doesn't same");
                          }
                        },
                        color: KPrimaryColor,
                        text: 'Sign Up',
                      ),

                      // Log In
                      Row(
                        children: [
                          const Text("Already have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                            },
                            child: const Text('Log In', style: TextStyle(fontWeight: FontWeight.bold, color: KPrimaryColor)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> signUp(BuildContext context, String email, String password,String username) async {
  try {
    UserCredential user = await Register.register(email, password,username);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
  } on FirebaseAuthException catch (exc) {
    if (exc.code == 'weak-password') {
      showSnackBar(context, 'Weak password');
    } else if (exc.code == 'email-already-in-use') {
      showSnackBar(context, 'Email already exist');
    } else if (exc.code == 'invalid-email') {
      showSnackBar(context, 'Invalid Email');
    } else if (exc.code == 'network-request-failed') {
      showSnackBar(context, 'No Internet');
    } else {
      print(exc.code);
      showSnackBar(context, 'Error');
    }
  } catch (exc) {
    print(exc);
    showSnackBar(context, 'Error');
  }
}
