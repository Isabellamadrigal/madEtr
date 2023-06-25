import 'package:boekiez/screens.dart/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';


import 'signupscreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final firebaseAuth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscureText = true;

  Future<void> login() async {
    if (emailController.text.isEmpty && passwordController.text.isEmpty) {
      EasyLoading.showError('Email and password cannot be empty');
      return;
    }
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        EasyLoading.showError('User not found.');
      } else if (e.code == 'wrong-password') {
        EasyLoading.showError('Wrong password.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: firebaseAuth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return splashscreen(
            userId: snapshot.data!.uid,
          );
        }

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Scaffold(
            body: 
            SingleChildScrollView(
              child: Column(
                
              children: <Widget>[
               // First widget is the image background
                Image.asset(
                  'assets/books.png',
                  width: 140,
                ),
                 Text('Welcome Back!',style: GoogleFonts.poppins(fontSize: 40,color:Colors.black,fontWeight: FontWeight.bold),),
                   // Text('sino ',style: GoogleFonts.poppins(fontSize: 20,color:Colors.grey,fontWeight: FontWeight.normal),)
            
                // SizedBox(height: 20,),
                    
                // Other widgets that should be on top of the background image
                Container(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                child: SingleChildScrollView(
                  child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Center(
                  child:  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Login',
                      style: GoogleFonts.poppins(
                        fontSize: 20
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                   decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                filled: true,
                fillColor: Colors.transparent,
                border: OutlineInputBorder(
                  //borderRadius: BorderRadius.circular(50.0),
                ),
                hintText: 'Enter Email',
              ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: passwordController,
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.fingerprint),
                    filled: true,
                fillColor: Colors.transparent,
                border: OutlineInputBorder(
                 // borderRadius: BorderRadius.circular(50.0),
                ),
                hintText: 'Enter Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  
                  style: ElevatedButton.styleFrom(
                    
                    backgroundColor: Colors.yellow[50]
                  ),
                  onPressed: login,
                  child: const Text(
                    'Login',
                    
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                    );
                  },
                  child:  Text(
                    'Create an account',
                   style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 16),
                  ),
                ),
              ],
                  ),
                ),
                ),
              ),
                  // Add your widgets here
                ),
              ],
                    ),
            ),
            
            
            
            
        ),
          ),
        );

      },
    );
  }
}