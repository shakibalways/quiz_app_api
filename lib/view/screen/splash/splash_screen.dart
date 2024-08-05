import 'package:flutter/material.dart';
import 'package:quiz_app/utilis/const/color_list.dart';
import 'package:quiz_app/view/screen/quiz_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Colors.lightBlue,
              RColor.blue,
              RColor.darkBlue,
            ])),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                "assets/images/quizballon.png",
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Welcome to our",
                style: TextStyle(color: RColor.lightGrey, fontSize: 18),
              ),
              const Text(
                "Quiz App Shakib",
                style: TextStyle(color: Colors.white, fontSize: 35),
              ),
              const SizedBox(height: 20),
              const Text(
                "Enjoy playing the quiz game as the same time gaiming knowladge as well best of luck!",
                style: TextStyle(fontSize: 18, color: RColor.lightGrey),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QuizScreen()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 50,
                    margin: const EdgeInsets.only(bottom: 25),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: const Text(
                      "Continue",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.blue),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
