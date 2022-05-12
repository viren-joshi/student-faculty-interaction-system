import 'package:flutter/material.dart';
import 'package:somaiya_project/constants.dart';
import 'package:somaiya_project/utilities/network_helper.dart';
import 'package:somaiya_project/utilities/shared_pref_manager.dart';

class PreviousQuestions extends StatefulWidget {
  const PreviousQuestions({Key? key}) : super(key: key);

  @override
  State<PreviousQuestions> createState() => _PreviousQuestionsState();
}

class _PreviousQuestionsState extends State<PreviousQuestions> {
  Future<Map> previousQuestions() async {
    int sID = await SharedPrefManager.getId();
    return NetworkHelper.getAllQuestionsForStudent(sID);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: previousQuestions(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.data != null) {
          if (snapshot.data['message'] == 'Success') {
            Map data = snapshot.data as Map;
            if (snapshot.data['isThere'] == 'Yes') {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ListView.separated(
                  itemCount: data.length - 2,
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      thickness: 2.0,
                      color: Color(0xFF082795),
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    Map<dynamic, dynamic> item = data['${index + 1}'];
                    if (item['status'] == 0) {
                      return UnansweredQuestionTile(
                        question: item['question'] ?? "Q ERROR",
                      );
                    } else {
                      return AnsweredQuestionTile(
                        question: item['question'] ?? "EA ERROR",
                        answer: item['answer'] ?? "ERROR",
                      );
                    }
                  },

                  // shrinkWrap: true,
                ),
              );
            } else {
              return const Center(
                child: Text(
                  'No Questions Asked',
                ),
              );
            }
          } else {
            return const Center(
              child: Text(
                'ERROR',
                style: TextStyle(color: Colors.red),
              ),
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class UnansweredQuestionTile extends StatelessWidget {
  final String question;

  const UnansweredQuestionTile({
    Key? key,
    required this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Question :',
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: kHyperlinkColor,
              fontSize: 18.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(question),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 10.0,
              top: 12.0,
            ),
            child: Text(
              'Status : Pending ',
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: kDarkColor,
                fontSize: 15.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnsweredQuestionTile extends StatelessWidget {
  final String question, answer;

  const AnsweredQuestionTile({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Question :',
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: kHyperlinkColor,
              fontSize: 18.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(question),
          ),
          const Text(
            'Answer:',
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: kHyperlinkColor,
              fontSize: 18.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(answer),
          ),
        ],
      ),
    );
  }
}
