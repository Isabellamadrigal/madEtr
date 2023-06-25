import 'package:boekiez/screens.dart/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';


import 'loginscreen.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final firebaseAuth = FirebaseAuth.instance;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscureText = true;

  void signup() async {
    if (emailController.text.isEmpty && passwordController.text.isEmpty) {
      EasyLoading.showError('Email and password cannot be empty');
      return;
    }
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text, fname: '',
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        EasyLoading.showError('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        EasyLoading.showError('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
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

        return Scaffold(
          body:
          SingleChildScrollView(
            child: Column(
            children: <Widget>[
              Image.asset(
                    'assets/books.png',
                    width: 140,
                  ),
                   Text('Get Started',style: GoogleFonts.poppins(fontSize: 50,color:Colors.black,fontWeight: FontWeight.bold),),
                     // Text('sino ',style: GoogleFonts.poppins(fontSize: 20,color:Colors.grey,fontWeight: FontWeight.normal),)
              
                  // SizedBox(height: 20,),
                      
                  // Other widgets that should be on top of the background image
                
              Container(
                child:
                Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
              child:  Text(
                'SignUp',
                style: GoogleFonts.poppins(
                        fontSize: 20
                      ),
              ),
            ),
                      const SizedBox(height: 24),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
              filled: true,
              fillColor: Colors.transparent,
              border: OutlineInputBorder(
               // borderRadius: BorderRadius.circular(50.0),
              ),
                          labelText: 'Email',
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: passwordController,
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.fingerprint),
              filled: true,
              fillColor: Colors.transparent,
              border: OutlineInputBorder(
//borderRadius: BorderRadius.circular(50.0),
              ),
                          labelText: 'Password',
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
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                    
                    backgroundColor: Colors.yellow[50]
                  ),
                          onPressed: signup,
                          child:  Text(
                            'Signup',
                             style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child:  Text(
                            'Login',
                            style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 16),
                          ),
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
          
          
           
        );
      },
    );
  }
}