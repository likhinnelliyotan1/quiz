import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:quiz/helper/helper.dart';

import 'models/question.dart';

void main() {
  runApp(MyApp());
}

Future<List<Question>> fetchQuestions() async {
  final response = await http.get(Uri.parse(
      'https://quizapi.io/api/v1/questions?apiKey=miKa0AK6KcwHjHIFwG6AVZd4fmyOM05lenRRO78f&category=linux&difficulty=Hard&limit=20'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => new Question.fromJson(data)).toList();

    // return  Question.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load quiz');
  }
}









class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'QUIZ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: colorPrimary,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: buttonColor,
          ),
        ),
        buttonTheme: const ButtonThemeData(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(20),
          )),
          buttonColor: buttonColor,
        ),
        textTheme: const TextTheme(
            bodyText1: TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
            headline1: TextStyle(
              color: colorPrimary,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            )),
        cardTheme: const CardTheme(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(20),
          )),
          color: Colors.white,
        ),
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Question>> futureQuestions;

  String cor_ans = '';
  List<bool> right = List.filled(20, false);
  List<bool> isSubmitted = List.filled(20, false);
  List<String> answer = List.filled(20, '');

  @override
  void initState() {
    super.initState();
    futureQuestions = fetchQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<List<Question>>(
              future: futureQuestions,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // ignore: deprecated_member_use
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, i) {
                              cor_ans = snapshot.data![i].correctAnswer != null
                                  ? snapshot.data![i].correctAnswer!
                                  : "";
                              print("start right :  " + right[i].toString());
                              return Column(
                                children: [
                                  isSubmitted[i] == true
                                      ? right[i] == true
                                          ? const CircleAvatar(
                                              backgroundColor: Colors.white,
                                              child: FaIcon(
                                                  FontAwesomeIcons.checkCircle))
                                          : const CircleAvatar(
                                              backgroundColor: Colors.white,
                                              child: FaIcon(
                                                  FontAwesomeIcons.windowClose))
                                      : CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: Text((i + 1).toString())),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Card(
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.6,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.45,
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "Question",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline1,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      (i + 1).toString() +
                                                          "/" +
                                                          snapshot.data!.length
                                                              .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline1,
                                                    ),
                                                  ],
                                                ),
                                                const IconButton(
                                                  onPressed: null,
                                                  icon: Icon(
                                                      Icons.more_vert_outlined),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: MediaQuery.of(context).size.height * 0.8-180,
                                              child: SingleChildScrollView(
                                                child: Center(

                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        snapshot.data![i].question!
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      snapshot.data![i].answers!
                                                                  .answerA ==
                                                              null
                                                          ? Container()
                                                          : ans(i, snapshot,
                                                              context, 'answer_a'),
                                                      snapshot.data![i].answers!
                                                                  .answerB ==
                                                              null
                                                          ? Container()
                                                          : ans(i, snapshot,
                                                              context, 'answer_b'),
                                                      snapshot.data![i].answers!
                                                                  .answerC ==
                                                              null
                                                          ? Container()
                                                          : ans(i, snapshot,
                                                              context, 'answer_c'),
                                                      snapshot.data![i].answers!
                                                                  .answerD ==
                                                              null
                                                          ? Container()
                                                          : ans(i, snapshot,
                                                              context, 'answer_d'),
                                                      snapshot.data![i].answers!
                                                                  .answerE ==
                                                              null
                                                          ? Container()
                                                          : ans(i, snapshot,
                                                              context, 'answer_e'),
                                                      snapshot.data![i].answers!
                                                                  .answerF ==
                                                              null
                                                          ? Container()
                                                          : ans(i, snapshot,
                                                              context, 'answer_f'),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    child: const Text(
                                      "SUBMIT",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: isSubmitted[i]
                                        ? null
                                        : () {
                                            if (answer[i] == cor_ans) {
                                              setState(() {
                                                print(" correct");
                                                right[i] = true;
                                                isSubmitted[i] = true;
                                                print(right[i].toString());
                                              });
                                            } else {
                                              setState(() {
                                                isSubmitted[i] = true;

                                                right[i] = false;
                                              });
                                              print("not correct");
                                            }
                                          },
                                  ),
                                ],
                              );
                            }),
                      ),

                      // SizedBox(
                      //   height:30,
                      //   child: ElevatedButton(
                      //     child: const Text(
                      //       "Show Score",
                      //       style: TextStyle(
                      //         color: Colors.white,
                      //         fontSize: 11
                      //       ),
                      //     ),
                      //     onPressed: ()
                      //       {
                      //         AlertDialog alert=AlertDialog(
                      //           title: Text("Score"),
                      //           content: Text(getScore()),
                      //           actions: [
                      //             InkWell(
                      //               onTap:(){
                      //                 Navigator.pop(context);
                      //               },
                      //               child: Text("Ok"),
                      //             ),
                      //           ],
                      //         );
                      //         showDialog(
                      //           context: context,
                      //           builder: (BuildContext context) {
                      //             return alert;
                      //           },
                      //         );
                      //       }
                      //   ),
                      // ),
                      SizedBox(height: 10,),
                      Text("Score: "+getScore(),style: TextStyle(fontSize: 18,color: Colors.white),)
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
  String getScore()
  {

    int score=0;

    for(int i=0;i<right.length;i++)
      {

        if(right[i]==true)
          score++;
      }
    return score.toString();
  }
  InkWell ans(int i, AsyncSnapshot<List<Question>> snapshot,
      BuildContext context, String text) {
    String a = '';
    switch (text) {
      case 'answer_a':
        a = snapshot.data![i].answers!.answerA.toString();
        break;
      case 'answer_b':
        a = snapshot.data![i].answers!.answerB.toString();
        break;
      case 'answer_c':
        a = snapshot.data![i].answers!.answerC.toString();
        break;
      case 'answer_d':
        a = snapshot.data![i].answers!.answerD.toString();
        break;
      case 'answer_e':
        a = snapshot.data![i].answers!.answerE.toString();
        break;
      case 'answer_f':
        a = snapshot.data![i].answers!.answerF.toString();
        break;
      default:
    }
    return InkWell(
      onTap: () {
        setState(() {
          answer[i] = text;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: answer[i] == text ?colorPrimary : Colors.grey[200],
          borderOnForeground: true,
          child: Container(
            width: 350,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  a,
                  style: answer[i] == text
                      ? Theme.of(context).textTheme.bodyText1
                      : TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
