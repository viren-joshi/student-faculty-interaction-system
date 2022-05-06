import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:somaiya_project/constants.dart';
import 'package:somaiya_project/screens/faculty/faculty_home_screen.dart';
import 'package:somaiya_project/screens/signup_screen.dart';
import 'package:somaiya_project/screens/student/student_home_screen.dart';
import 'package:somaiya_project/utilities/network_helper.dart';
import 'package:somaiya_project/widgets/custom_snackbar.dart';
import 'package:somaiya_project/widgets/custom_text_field.dart';
import 'package:somaiya_project/widgets/submit_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  bool isTeacherSelected = true;
  bool isSpinning = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlurryModalProgressHUD(
        inAsyncCall: isSpinning,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: Padding(
              padding: const EdgeInsets.only(top: 2.0, left: 5.0),
              child: Image.asset('images/somaiya_logo.jpg'),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('images/somaiya_trust.jpg'),
              )
            ],
            elevation: 0.0,
            // toolbarHeight: 75.0,
          ),
          body: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height / 4.5,
                          decoration: BoxDecoration(
                            color: isTeacherSelected ? kDarkColor : kLightColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: TextButton(
                            onPressed: () => setState(() {
                              isTeacherSelected = true;
                            }),
                            child: const Center(
                              child: Text(
                                'Teachers',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height / 4.5,
                          decoration: BoxDecoration(
                            color: isTeacherSelected ? kLightColor : kDarkColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: TextButton(
                            onPressed: () => setState(() {
                              isTeacherSelected = false;
                            }),
                            child: const Center(
                              child: Text(
                                'Student',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Log In',
                        style: TextStyle(
                            fontSize: 40.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CustomTextField(
                          hintText: 'Somaiya Email',
                          onChangedCallback: (String? val) {
                            if (val != null) {
                              email = val;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CustomTextField(
                            hintText: 'Password',
                            onChangedCallback: (String? val) {
                              if (val != null) {
                                password = val;
                              }
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            showErrorSnackbar(
                                context, 'Sorry, something went wrong :(');
                          },
                          child: const Text(
                            'Forgot Password',
                            textAlign: TextAlign.right,
                            style: TextStyle(color: kHyperlinkColor),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: SubmitButton(
                          onPressesCallback: () async {
                            setState(() {
                              isSpinning = true;
                            });
                            if (isTeacherSelected) {
                              //Login With Teacher
                              setState(() {
                                isSpinning = false;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const FacultyHomeScreen(),
                                ),
                              );
                            } else {
                              //Login With Student
                              // var response = await NetworkHelper.loginAsStudent(
                              //     email, password);
                              setState(() {
                                isSpinning = false;
                              });
                              // if (kDebugMode) {
                              //   print(response);
                              // }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const StudentHomeScreen(),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Don't have an Account ? Tap Here !",
                          style: TextStyle(color: kHyperlinkColor),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
