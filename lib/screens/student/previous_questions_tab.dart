import 'package:flutter/material.dart';
import 'package:somaiya_project/constants.dart';

class PreviousQuestions extends StatefulWidget {
  const PreviousQuestions({Key? key}) : super(key: key);

  @override
  State<PreviousQuestions> createState() => _PreviousQuestionsState();
}

class _PreviousQuestionsState extends State<PreviousQuestions> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListView.separated(
        itemCount: 10,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            thickness: 2.0,
            color: Color(0xFF082795),
          );
        },
        itemBuilder: (BuildContext context, int index) {
          if (index % 2 == 0) {
            return const AnsweredQuestionTile();
          } else {
            return const UnansweredQuestionTile();
          }
        },

        // shrinkWrap: true,
      ),
    );
  }
}

class UnansweredQuestionTile extends StatelessWidget {
  const UnansweredQuestionTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Text(
            'Question :',
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: kHyperlinkColor,
              fontSize: 18.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('ABCD EFGH IKLSFJKJEHG HDKJGHRT HKJHJDGJKT KJDGKJRHT'),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 10.0,
              top: 12.0,
            ),
            child: Text(
              'Staus : Pending ',
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
  const AnsweredQuestionTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Text(
            'Question :',
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: kHyperlinkColor,
              fontSize: 18.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('ABCD EFGH IKLSFJKJEHG HDKJGHRT HKJHJDGJKT KJDGKJRHT'),
          ),
          Text(
            'Answer:',
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: kHyperlinkColor,
              fontSize: 18.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('JSKFHEKJFHEJAHDFKJ'),
          ),
        ],
      ),
    );
  }
}
