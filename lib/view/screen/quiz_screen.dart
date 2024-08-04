import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_app/controller/api_service/quiz_service.dart';
import 'package:quiz_app/utilis/const/color_list.dart';
import 'package:quiz_app/view/screen/result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late Future quiz;
  int seconds = 60;
  var currentIndexQuestion = 0;
  Timer? timer;
  bool isLoading = false;
  var optionList = [];
  int correctAnswers = 0;
  int incorrectAnswers = 0;
  @override
  void initState() {
    quiz = getQuizData();
    startTimer();
    super.initState();
  }

  var optionColor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];
  // reset color after
  resetColor() {
    optionColor = [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
    ];
  }

  startTimer() async {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          gotoNextQuestion();
        }
      });
    });
  }

  gotoNextQuestion() {
    setState(() {
      isLoading = false;
      resetColor();
      currentIndexQuestion++;
      timer!.cancel();
      seconds = 60;
      startTimer();
    });
  }

// now we call the timer as well
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue, RColor.blue, RColor.darkBlue])),
        child: FutureBuilder(
          future: quiz,
          builder: (BuildContext, AsyncSnapshot snapshot) {
            // for error handling
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error:${snapshot.error}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
              );
            } else if (snapshot.hasData) {
              var data = snapshot.data["results"];
              if (isLoading == false) {
                optionList = data[currentIndexQuestion]['incorrect_answers'];
                optionList.add(data[currentIndexQuestion]['correct_answer']);
                optionList
                    .shuffle(); // it makes the current answer in different index
                isLoading = true;
              }
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border:
                                    Border.all(color: Colors.red, width: 2)),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.red,
                                size: 30,
                              ),
                            ),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Text(
                                "$seconds",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                              SizedBox(
                                height: 70,
                                width: 70,
                                child: CircularProgressIndicator(
                                  value: seconds / 60,
                                  valueColor: const AlwaysStoppedAnimation(
                                      Colors.white),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Image.asset(
                          "assets/images/ideas.png",
                          width: 250,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Question ${currentIndexQuestion + 1} of ${data.length}",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        data[currentIndexQuestion]['question'],
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: optionList.length,
                          itemBuilder: (context, int index) {
                            var correctAnswer =
                                data[currentIndexQuestion]['correct_answer'];
                            // keep in mind the answer is exactly same, other wise you face the error
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (correctAnswer.toString() ==
                                      optionList[index].toString()) {
                                    //correct option color
                                    optionColor[index] = Colors.green;
                                    correctAnswers++; // it means add the correct answer number until the las question
                                  } else {
                                    // delay 1 section after selection any option
                                    optionColor[index] = Colors.red;
                                    incorrectAnswers++; // it means add the incorrect answer number until the las question
                                  }
                                  if (currentIndexQuestion < data.length - 1) {
                                    Future.delayed(
                                        const Duration(milliseconds: 400), () {
                                      gotoNextQuestion();
                                    });
                                  } else {
                                    timer!.cancel();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ResultScreen(
                                                correctAnswers,
                                                incorrectAnswers,
                                                currentIndexQuestion)));
                                  }
                                });
                                // until now our app is hold on last question now we have display the final result;
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: optionColor[index],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  optionList[index].toString(),
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text("No Data Found"),
              );
            }
          },
        ),
      ),
    );
  }
}
