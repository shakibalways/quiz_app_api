import 'package:flutter/material.dart';
import 'package:quiz_app/utilis/const/color_list.dart';
import 'package:quiz_app/view/screen/splash/splash_screen.dart';

class ResultScreen extends StatelessWidget {
  final int correctAnswer;
  final int incorrectAnswer;
  final int totalQuestion;

  const ResultScreen(
      {super.key,
      required this.correctAnswer,
      required this.incorrectAnswer,
      required this.totalQuestion});

  @override
  Widget build(BuildContext context) {
    double correctPercentage = (correctAnswer /
        totalQuestion *
        100); //formula to converse number into percentage
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          gradient:
              LinearGradient(colors: [Colors.blue, RColor.blue, RColor.darkBlue]),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Congratulation",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                "${correctPercentage.toStringAsFixed(1)}%",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                "Correct Answer: $correctAnswer",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              Text(
                "InCorrect Answer: $incorrectAnswer",
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SplashScreen()));
                  },
                  child: Text("Back to Home"))
            ],
          ),
        ),
      ),
    );
  }
}
