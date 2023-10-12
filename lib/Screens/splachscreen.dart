import 'package:ecommerce_app/Screens/SignUpPage.dart';
import 'package:ecommerce_app/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import '../NavBar.dart';
import 'LoginPage.dart';


class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(Duration(seconds: 4), (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_)=> LoginPage() ));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual , 
    overlays: SystemUiOverlay.values);
    super.dispose();
  }


  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/images/splashAnimation.json"),

            SizedBox(height: 20,),

            CircularProgressIndicator(
              color: Purple,
            )
          ],
        ),
      ),

    );
  }
}