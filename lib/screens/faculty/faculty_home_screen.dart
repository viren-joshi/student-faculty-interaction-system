import 'package:flutter/material.dart';
import 'package:somaiya_project/constants.dart';
import 'package:somaiya_project/screens/faculty/answer_question_screen.dart';
import 'package:somaiya_project/screens/login_screen.dart';
import 'package:somaiya_project/utilities/network_helper.dart';
import 'package:somaiya_project/utilities/shared_pref_manager.dart';

class FacultyHomeScreen extends StatefulWidget {
  const FacultyHomeScreen({Key? key}) : super(key: key);

  @override
  State<FacultyHomeScreen> createState() => _FacultyHomeScreenState();
}

class _FacultyHomeScreenState extends State<FacultyHomeScreen> {
  Future<Map> getAllQuestionsForFaculty() async {
    int fID = await SharedPrefManager.getId();
    return await NetworkHelper.getAllQuestionsForFaculty(fID);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const FacultyDrawer(),
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
          // toolbarHeight: 75.0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'All Questions',
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {});
                  },
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder(
                future: getAllQuestionsForFaculty(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data != null) {
                    if (snapshot.data['message'] == 'Success') {
                      if (snapshot.data['isThere'] == 'Yes') {
                        Map data = snapshot.data as Map;
                        return ListView.separated(
                          itemCount: data.length - 2,
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(
                              thickness: 2.0,
                              color: Color(0xFF082795),
                            );
                          },
                          itemBuilder: (BuildContext context, int index) {
                            Map item = data[(index + 1).toString()];
                            return AllFacultyQuestionsTile(
                              question: item['question'],
                              answerButton: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AnswerQuestionScreen(
                                      question: item['question'],
                                      qID: item['quest_id'],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text(
                            'No Questions To Be Answered',
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AllFacultyQuestionsTile extends StatelessWidget {
  final String question;
  final void Function() answerButton;

  const AllFacultyQuestionsTile({
    Key? key,
    required this.question,
    required this.answerButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
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
            padding: EdgeInsets.only(left: 20.0),
            child: Text(question),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 50.0,
              vertical: 10.0,
            ),
            child: GestureDetector(
              onTap: answerButton,
              child: Container(
                decoration: const BoxDecoration(
                    color: kLightColor,
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 35.0),
                  child: Text(
                    'Answer',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FacultyDrawer extends StatefulWidget {
  const FacultyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<FacultyDrawer> createState() => _FacultyDrawerState();
}

class _FacultyDrawerState extends State<FacultyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kDrawerColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              title: const Text(
                'Home',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 25.0,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            // ListTile(
            //   title: Text(
            //     'Profile',
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontWeight: FontWeight.w400,
            //       fontSize: 25.0,
            //     ),
            //   ),
            // ),
            // ListTile(
            //   title: Text(
            //     'Answered Questions',
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontWeight: FontWeight.w400,
            //       fontSize: 25.0,
            //     ),
            //   ),
            // ),
            ListTile(
              title: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 25.0,
                ),
              ),
              onTap: () {
                SharedPrefManager.logout();
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
