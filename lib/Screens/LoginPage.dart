// ignore_for_file: file_names
import 'package:ecommerce_app/Global%20Variables/Global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../NavBar.dart';
import '../constant/constant.dart';
import '../logic/helper.dart';
import 'SignUpPage.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> keyForm = GlobalKey();
  bool isLoading = false;
  String? email;
  String? password;
  bool rememberMe=false;
  void getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool("dark")!=null)
      Global.dark=prefs.getBool("dark")!;
    if(prefs.getBool('rememberMe')!=null&&prefs.getBool('rememberMe')==true) {
      email = prefs.getString('email');
      password = prefs.getString('password');
      login(context, email!, password!,rememberMe);
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefs();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: ListView(
            children: [
              Lottie.asset('assets/images/animation_lly51vak.json', height: MediaQuery.of(context).size.height *0.4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Form(
                  key: keyForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Log In
                      const Text('Log In', style: TextStyle(color: KPrimaryColor, fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 30),

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
                      SizedBox(height: 10,),
                    CheckboxListTile(
                      title: Text("Remember Me"),
                      value: rememberMe,
                      onChanged: (newValue) {
                        setState(() {
                          rememberMe=newValue!;
                        });

                      },
                      activeColor: Purple,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                      const SizedBox(height: 30),

                      // Log In Button
                      CustomButton(
                        onTap: () async {
                          if (keyForm.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            await login(context, email!, password!,rememberMe);
                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
                        color: KPrimaryColor,
                        text: 'Log In',
                      ),

                      // Sign Up
                      Row(
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
                            },
                            child: const Text('Sign Up', style: TextStyle(fontWeight: FontWeight.bold, color: KPrimaryColor)),
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
void savePrefs(String email,String password,bool rememberMe) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('email', email);
  prefs.setString('password', password);
  prefs.setBool('rememberMe', rememberMe);

}
Future<void> login(BuildContext context, String email, String password,bool rememberMe) async {
  try {

    UserCredential user = await SignIn.signIn(email, password);
    savePrefs(email,password,rememberMe);
    Global.email = user.user!.email;
    User? user2=FirebaseAuth.instance.currentUser;
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user2?.uid)
        .get();
    Global.username = userDoc.get('username');

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NaviBar()));
  } on FirebaseAuthException catch (exc) {
    if (exc.code == 'user-not-found') {
      showSnackBar(context, 'Email not found');
    } else if (exc.code == 'wrong-password') {
      showSnackBar(context, 'Wrong Email or Password');
    } else if (exc.code == 'invalid-email') {
      showSnackBar(context, 'Invalid Email');
    } else if (exc.code == 'network-request-failed') {
      showSnackBar(context, 'No Internet');
    } else {
      showSnackBar(context, 'Error');
    }
  } catch (exc) {
    print(exc);
    showSnackBar(context, 'Error');
  }
}

// zeyad@gmail.com

// 06062003