import 'package:flutter/material.dart';
import 'package:somaiya_project/constants.dart';
import 'package:somaiya_project/screens/student/ask_question_tab.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({Key? key}) : super(key: key);

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: StudentDrawer(),
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: kGray, size: 45.0),
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 2.0, left: 5.0),
                child: Image.asset('images/somaiya_logo.jpg'),
              ),
              const SizedBox(width: 5.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('images/somaiya_trust.jpg'),
              )
            ],
            elevation: 0.0,
            bottom: const TabBar(
              automaticIndicatorColorAdjustment: true,
              indicatorColor: kDarkColor,
              labelColor: kDarkColor,
              labelStyle: TextStyle(fontWeight: FontWeight.w600),
              unselectedLabelStyle:
                  TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
              unselectedLabelColor: kLightColor,
              tabs: [
                Tab(text: 'Ask a Question'),
                Tab(text: 'Previous Question')
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              AskAQuestionTab(),
              PreviousQuestions(),
            ],
          ),
        ),
      ),
    );
  }
}

class StudentDrawer extends StatelessWidget {
  const StudentDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kDrawerColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            ListTile(
              title: Text(
                'Home',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 25.0,
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 25.0,
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 25.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

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
