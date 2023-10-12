import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constant/constant.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({super.key, required this.hintText, required this.onChanged, this.prefixIcon, this.obscureText = false, required this.label});

  final String hintText;
  final void Function(String data) onChanged;
  final IconData? prefixIcon;
  final String label;
  bool obscureText;
  IconData icon = Icons.remove_red_eye_outlined;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final controller = TextEditingController();
  bool? foucs;
  Color color = Colors.grey;
  final errorColor = Colors.red;
  final noErrorFoucsColor = KPrimaryColor;
  final noErrornoFoucsColor = Colors.grey;
  bool? show;

  @override
  void initState() {
    super.initState();
    show = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (foucsed) {
        foucs = foucsed;
        if (foucsed && color != errorColor) {
          setState(() {
            color = noErrorFoucsColor;
          });
        } else if (foucsed == false && color != errorColor) {
          setState(() {
            color = noErrornoFoucsColor;
          });
        }
      },
      child: TextFormField(
        validator: (data) {
          if (data!.isEmpty) {
            setState(() {
              color = errorColor;
            });
            return 'Field is required';
          } else if (foucs == true) {
            setState(() {
              color = noErrorFoucsColor;
            });
          } else {
            setState(() {
              color = noErrornoFoucsColor;
            });
          }
          return null;
        },
        cursorColor: color,
        obscureText: show!,
        onChanged: widget.onChanged,
        controller: controller,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(KRadius))),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: color, width: 2), borderRadius: const BorderRadius.all(Radius.circular(KRadius))),
          label: Text(widget.label),
          labelStyle: TextStyle(color: color),
          hintText: widget.hintText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintStyle: TextStyle(color: color, fontSize: 15),
          prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon, color: color) : null,
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(widget.icon, color: color),
                  onPressed: () {
                    show = !show!;
                    if (show!) {
                      widget.icon = Icons.remove_red_eye_outlined;
                    } else {
                      widget.icon = Icons.remove_red_eye;
                    }
                    setState(() {});
                  })
              : null,
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onTap, required this.text, required this.color});

  final void Function() onTap;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(KRadius), color: color),
      child: MaterialButton(
        onPressed: onTap,
        height: 50,
        minWidth: double.infinity,
        child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 18)),
      ),
    );
  }
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: const TextStyle(fontSize: 17, color: Colors.white)),
      backgroundColor: KPrimaryColor,
      duration: const Duration(seconds: 2),
    ),
  );
}

class SignIn {
  static Future<UserCredential> signIn(String email, String password) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  }
}

class Register {
  static Future<UserCredential> register(
      String email, String password, String username) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .set({'username': username}, SetOptions(merge: true));
    return userCredential;
  }
}