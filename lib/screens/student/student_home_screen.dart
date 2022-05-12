import 'package:flutter/material.dart';
import 'package:somaiya_project/constants.dart';
import 'package:somaiya_project/screens/login_screen.dart';
import 'package:somaiya_project/screens/student/ask_question_tab.dart';
import 'package:somaiya_project/screens/student/previous_questions_tab.dart';
import 'package:somaiya_project/utilities/shared_pref_manager.dart';

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
          drawer: const StudentDrawer(),
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
                    builder: (_) => const LoginScreen(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
