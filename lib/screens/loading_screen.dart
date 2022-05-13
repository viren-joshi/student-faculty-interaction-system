import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:somaiya_project/screens/faculty/faculty_home_screen.dart';
import 'package:somaiya_project/screens/login_screen.dart';
import 'package:somaiya_project/screens/student/student_home_screen.dart';
import 'package:somaiya_project/utilities/shared_pref_manager.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  Future<Map<String, bool>> logInBool() async {
    bool isLoggedIn = await SharedPrefManager.isLoggedIn();
    bool isStudent = await SharedPrefManager.isLoggedInAsStudent();
    return {'isLoggedIn': isLoggedIn, 'isStudent': isStudent};
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: logInBool(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              if (snapshot.data['isLoggedIn']) {
                if (snapshot.data['isStudent']) {
                  SchedulerBinding.instance.addPostFrameCallback((_){
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StudentHomeScreen(),
                      ),
                    );
                  });
                } else {
                  SchedulerBinding.instance.addPersistentFrameCallback((_) {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const FacultyHomeScreen(),
                      ),
                    );
                  });
                }
              } else {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LoginScreen(),
                    ),
                  );
                });
              }
            }
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset('images/somaiya_logo.jpg'),
              ),
            );
          },
        ),
      ),
    );
  }
}
