
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'loadingscreen.dart';

class splashscreen extends StatefulWidget {
   splashscreen({super.key , required this.userId});
  final String userId;

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      backgroundColor: Colors.yellow,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      Container(
                        child: Container(
                          
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(),
                            color: Colors.yellow,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            opacity: (0.3),
                            image: AssetImage("assets/overlay.png"),
                            fit: BoxFit.cover
                          )
                          
                        ),
                      ),
                      Center(
                        child: Container(
                                child: Image.asset("assets/books.png")),
                      ),
                      
                    ],
                  )),
              SingleChildScrollView(
                child: Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(30),
                          child: Text(
                            "Online BookHub",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 38,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Text(
                          "The book can change your life",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35.0),
                          child: Text(
                            "Dive into new worlds with our application,",
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(color: Colors.grey[600])),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35.0),
                          child: Text(
                            "explore, study, follow the arrival of books,",
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(color: Colors.grey[600])),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35.0),
                          child: Text(
                            "get into good habbit of reading.",
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(color: Colors.grey[600])),
                          ),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60.0),
                          child: GestureDetector(
                            onTap: (() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  var l = [
                                    "mystery",
                                    "fantasy",
                                    "horror",
                                    "romance"
                                  ];
                                  return loadingscreen(l: l);
                                }),
                              );
                            }),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.yellow[100],
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Next",
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w900)),
                                  ),
                                   Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
